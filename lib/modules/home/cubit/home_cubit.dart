
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/modules/home/repository/home_repository.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IHomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeLoading()) {
    load();
  }
  load() async {
    try {
      var data = await homeRepository.getAllPokemons();
      List<Map<String, dynamic>> listDataItem = [];
      for (var i = 1; i <= (data.results?.length ?? 1); i++) {
        try {
          var response = await homeRepository.pokemonItem(i);
          listDataItem.add(response);
        } catch (e) {
          debugPrint("error: $e");
        }
      }
      emit(HomeSuccess(data, listDataItem));
    } catch (e) {
            debugPrint(e.toString());
    }
  }
}

void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => debugPrint(match.group(0)));
}
