// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:poke_app/modules/detail/model/detail_pokemon.dart';

abstract class DetailState extends Equatable {
  const DetailState();
  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {}

class DetailSuccess extends DetailState {
  DetailDescription data;
  DetailSuccess(this.data);
}

class DetailError extends DetailState {
  final String? message;
  const DetailError({this.message});
}
