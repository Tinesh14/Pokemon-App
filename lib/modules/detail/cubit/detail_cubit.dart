// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/modules/detail/cubit/detail_state.dart';
import 'package:poke_app/modules/detail/model/detail_pokemon.dart';
import 'package:poke_app/modules/detail/repository/detail_repository.dart';

class DetailCubit extends Cubit<DetailState> {
  final IDetailRepository detailRepository;
  int id;
  DetailCubit(this.detailRepository, this.id) : super(DetailLoading()) {
    load();
  }

  load() async {
    try {
      emit(DetailLoading());
      var response = await detailRepository.getDescription(id);
      if (response != null) {
        var data = DetailDescription.fromJson(response);
        emit(DetailSuccess(data));
      } else {
        emit(DetailError());
      }
    } catch (e) {
      debugPrint('error: $e');
      emit(DetailError());
    }
  }
}
