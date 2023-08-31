// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/modules/home/cubit/home_cubit.dart';
import 'package:poke_app/modules/home/cubit/home_state.dart';
import 'package:poke_app/modules/home/repository/home_repository.dart';
import 'package:poke_app/modules/network/services.dart';

import 'card_widget.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(
              HomeRepository(DioService()),
            ),
          )
        ],
        child: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeSuccess) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(
                    state.dataPokemon.results!.length,
                    (index) {
                      // return Container();
                      return state.dataItem[index] != null
                          ? PokemonCardWidget(pokemon: state.dataItem[index])
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                  //
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
