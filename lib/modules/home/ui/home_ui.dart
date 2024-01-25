// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/modules/home/cubit/home_cubit.dart';
import 'package:poke_app/modules/home/cubit/home_state.dart';
import 'package:poke_app/modules/home/repository/home_repository.dart';

import 'card_widget.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  final TextEditingController _searchController = TextEditingController();
  BuildContext? ctx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(
              HomeRepository(context),
            ),
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search pokemon name ...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            if (ctx != null) {
                              BlocProvider.of<HomeCubit>(ctx!).load();
                            }
                            _searchController.clear();
                          }
                        },
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (ctx != null) {
                            BlocProvider.of<HomeCubit>(ctx!)
                                .search(_searchController.text);
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<HomeCubit, HomeState>(
                // buildWhen: (previous, current) =>
                //     current is HomeLoading || current is HomeSuccess,
                builder: (context, state) {
                  ctx = context;
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeSuccess) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(
                          state.dataPokemon.length,
                          (index) {
                            return state.dataItem[index] != null
                                ? PokemonCardWidget(
                                    pokemon: state.dataItem[index])
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                      ),
                    );
                  } else if (state is HomeError) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (_searchController.text.isNotEmpty) {
                              _searchController.clear();
                              FocusScope.of(context).unfocus();
                            }
                            BlocProvider.of<HomeCubit>(context).load();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Try Again",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Visibility(
                          visible: state.message?.isNotEmpty ?? false,
                          child: Text(
                            state.message ?? "Error !!!",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is HomeEmptyData) {
                    return const Center(
                      child: Text(
                        'No Data .....',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                listener: (context, state) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
