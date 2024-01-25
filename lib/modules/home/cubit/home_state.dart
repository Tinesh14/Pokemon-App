import 'package:equatable/equatable.dart';
import 'package:poke_app/modules/home/model/pokemon.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  final int? loadingPercentage;
  const HomeLoading({this.loadingPercentage});

  HomeLoading copyWith({
    int? loadingPercentage,
  }) {
    return HomeLoading(
        loadingPercentage: loadingPercentage ?? this.loadingPercentage);
  }
}

class HomeSuccess extends HomeState {
  final List<Results> dataPokemon;
  final List<Map<String, dynamic>> dataItem;
  const HomeSuccess(this.dataPokemon, this.dataItem);
}

class HomeEmptyData extends HomeState {}

class HomeError extends HomeState {
  final String? message;
  const HomeError({this.message});
}
