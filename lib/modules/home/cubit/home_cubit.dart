// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poke_app/modules/home/repository/home_repository.dart';

import '../model/pokemon.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IHomeRepository homeRepository;
  late Box<List>? boxPokemon;
  late Box<List>? boxPokemonDetail;
  HomeLoading loadingState = const HomeLoading();
  HomeCubit(this.homeRepository) : super(const HomeLoading()) {
    init();
  }

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ResultsAdapter());
    boxPokemon = await Hive.openBox("pokemon");
    boxPokemonDetail = await Hive.openBox("pokemonDetail");
    load();
  }

  @override
  Future<void> close() async {
    await boxPokemon?.close();
    await boxPokemonDetail?.close();
    super.close();
  }

  search(String search) {
    try {
      emit(HomeLoading());
      List<Results> dataResults = [];
      List<Map<String, dynamic>> dataDetail = [];
      if (boxPokemon?.isNotEmpty ?? false) {
        boxPokemon?.values.cast<List>().forEach(
          (element) {
            for (var item in element) {
              if (item is Results) {
                dataResults.add(item);
              }
            }
          },
        );
      }
      if (boxPokemonDetail?.isNotEmpty ?? false) {
        boxPokemonDetail?.values.cast<List>().forEach(
          (element) {
            for (var item in element) {
              dataDetail.add(jsonDecode(jsonEncode(item)));
            }
          },
        );
      }
      var searchData = dataResults
          .where((element) => element.name?.contains(search) ?? false)
          .toList();
      var searchDetailData = <Map<String, dynamic>>[];

      for (var element in dataDetail) {
        element.forEach((key, value) {
          if (key == "name" && value is String && value.contains(search)) {
            searchDetailData.add(element);
          }
        });
      }
      if (searchData.isNotEmpty && searchDetailData.isNotEmpty) {
        emit(HomeSuccess(searchData, searchDetailData));
      } else {
        emit(HomeEmptyData());
      }
    } catch (e) {
      debugPrint("error $e");
      emit(HomeError(message: e.toString()));
    }
  }

  load() async {
    try {
      emit(HomeLoading());
      List<Map<String, dynamic>> listDataItem = [];
      List<Results> dataResults = [];
      List<Map<String, dynamic>> dataDetail = [];
      if (boxPokemon?.isNotEmpty ?? false) {
        boxPokemon?.values.cast<List>().forEach(
          (element) {
            for (var item in element) {
              if (item is Results) {
                dataResults.add(item);
              }
            }
          },
        );
      }
      if (boxPokemonDetail?.isNotEmpty ?? false) {
        boxPokemonDetail?.values.cast<List>().forEach(
          (element) {
            for (var item in element) {
              dataDetail.add(jsonDecode(jsonEncode(item)));
            }
          },
        );
      }
      if (dataResults.isEmpty) {
        var response = await homeRepository.getAllPokemons(20, 0);
        if (response != null) {
          var data = PokemonsModel.fromJson(response);
          if ((data.results?.isNotEmpty ?? false) &&
              (boxPokemon?.isEmpty ?? false)) {
            boxPokemon?.add(data.results!);
          }
          if (data.results?.isNotEmpty ?? false) {
            for (var i = 0; i < (data.results?.length ?? 1); i++) {
              try {
                var responsePokemonItem = await homeRepository
                    .pokemonItem(data.results?[i].name ?? "");
                debugPrint('loading ..... ${i + 1}');
                listDataItem.add(responsePokemonItem);
              } catch (e) {
                emit(HomeError(message: e.toString()));
                debugPrint("error: $e");
              }
            }
            if ((boxPokemonDetail?.isEmpty ?? false)) {
              boxPokemonDetail?.add(listDataItem);
            }
          }
          emit(HomeSuccess(data.results ?? [], listDataItem));
        } else {
          emit(HomeError());
        }
      } else {
        if (dataDetail.isEmpty) {
          for (var i = 0; i < (dataResults.length); i++) {
            try {
              var responsePokemonItem =
                  await homeRepository.pokemonItem(dataResults[i].name ?? "");
              debugPrint('loading ..... ${i + 1}');
              listDataItem.add(responsePokemonItem);
            } catch (e) {
              emit(HomeError(message: e.toString()));
              debugPrint("error: $e");
            }
          }
          if ((boxPokemonDetail?.isEmpty ?? false)) {
            boxPokemonDetail?.add(listDataItem);
          }
          emit(HomeSuccess(dataResults, listDataItem));
        } else {
          emit(HomeSuccess(dataResults, dataDetail));
        }
      }
    } catch (e) {
      debugPrint("error $e");
      emit(HomeError(message: e.toString()));
    }
  }
}

void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => debugPrint(match.group(0)));
}
