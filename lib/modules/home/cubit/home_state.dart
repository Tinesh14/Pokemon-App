import 'package:equatable/equatable.dart';
import 'package:poke_app/modules/home/model/pokemon.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final PokemonsModel dataPokemon;
  final List<Map<String, dynamic>> dataItem;
  const HomeSuccess(this.dataPokemon, this.dataItem);
}

class HomeError extends HomeState {
  final String? message;
  const HomeError(this.message);
}
