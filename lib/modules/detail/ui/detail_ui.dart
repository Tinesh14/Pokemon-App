import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/modules/detail/repository/detail_repository.dart';
import 'package:poke_app/modules/home/ui/card_widget.dart';
import 'package:poke_app/modules/network/services.dart';

import '../../utils/api.dart';
import '../cubit/detail_cubit.dart';
import '../cubit/detail_state.dart';
import 'detail_card_widget.dart';

class DetailUi extends StatefulWidget {
  const DetailUi({Key? key}) : super(key: key);

  @override
  State<DetailUi> createState() => _DetailUiState();
}

class _DetailUiState extends State<DetailUi> {
  @override
  Widget build(BuildContext context) {
    var pokemon =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var firstData = (pokemon?['types'] as List).first;
    return Scaffold(
      backgroundColor: StatsNames.color(type: firstData['type']['name']),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (pokemon?['name'] as String? ?? '').toFirstLetterCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            Text(
              '#${pokemon?['id'].toString().padLeft(3, '0')}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.only(top: 160),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => DetailCubit(
                        DetailRepository(context),
                        pokemon?['id'],
                      ),
                    ),
                  ],
                  child: BlocConsumer<DetailCubit, DetailState>(
                    builder: (context, state) {
                      if (state is DetailLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is DetailSuccess) {
                        return DetailsCardWidget(
                          pokemon: pokemon ?? {},
                          description: state.data,
                        );
                      } else {
                        return Container();
                      }
                    },
                    listener: (context, state) {},
                  ),
                ),
                Positioned(
                  top: -160,
                  left: 180,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset(
                      'assets/images/pokeball.svg',
                    ),
                  ),
                ),
                Positioned(
                  top: -125,
                  left: 90,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Hero(
                      tag: pokemon?['id'],
                      child: SvgPicture.network(
                        API.REQUEST_POKEMON_IMG(pokemon?['id']),
                        placeholderBuilder: ((context) {
                          return Container(
                              padding: const EdgeInsets.all(16),
                              child: const CircularProgressIndicator());
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
