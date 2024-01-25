import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:poke_app/modules/detail/model/detail_pokemon.dart';
import 'package:poke_app/modules/home/ui/card_widget.dart';

class DetailsCardWidget extends StatelessWidget {
  final Map<String, dynamic> pokemon;
  final DetailDescription description;

  const DetailsCardWidget({
    Key? key,
    required this.pokemon,
    required this.description,
  }) : super(key: key);
  percentage(partialValue, totalValue) {
    return ((100 * partialValue) / totalValue) / 100;
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('0,0');
    var firstData = (pokemon['types'] as List).first;
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(height: 44),
          SizedBox(
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemCount: pokemon['types'].length,
              itemBuilder: (_, index) {
                var data = pokemon['types'][index];
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  height: 20,
                  decoration: BoxDecoration(
                    color: StatsNames.color(type: firstData['type']['name']),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text(
                      (data['type']['name'] as String).toFirstLetterCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/icon_weight.svg'),
                      const SizedBox(width: 8),
                      Text(
                        '${formatter.format(pokemon['weight'])} kg',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Weight',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/icon_height.svg'),
                      const SizedBox(width: 8),
                      Text(
                        '${formatter.format(pokemon['height'])} m',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Weight',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: pokemon['abilities'].length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Center(
                            child: Text((pokemon['abilities'][index]['ability']
                                    ['name'] as String)
                                .toFirstLetterCase()));
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Moves',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            description.flavorTextEntries!.first.flavorText
                .toString()
                .replaceAll('\n', ' ')
                .replaceAll('\f', ' '),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Base Stats',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: StatsNames.color(type: firstData['type']['name']),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                itemCount: pokemon['stats'].length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 47,
                        child: Text(
                          StatsNames.statName(
                            stat: (pokemon['stats'][index]['stat']['name']
                                    as String)
                                .toLowerCase(),
                          ).toString().toUpperCase(),
                          style: TextStyle(
                            color: StatsNames.color(
                                type: firstData['type']['name']),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 21,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                        width: 50,
                        child: Center(
                          child: Text(
                            pokemon['stats'][index]['base_stat']
                                .toString()
                                .padLeft(3, '0'),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: percentage(
                              pokemon['stats'][index]['base_stat'], 255),
                          minHeight: 6,
                          backgroundColor:
                              StatsNames.color(type: firstData['type']['name'])
                                  ?.withOpacity(.2),
                          valueColor: AlwaysStoppedAnimation<Color?>(
                            StatsNames.color(type: firstData['type']['name']),
                          ),
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class StatsNames {
  static String? statName({required String stat}) {
    switch (stat) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SATK';
      case 'special-defense':
        return 'SDEF';
      case 'speed':
        return 'SPD';
    }
    return null;
  }

  static Color? color({required String type}) {
    switch (type) {
      case 'rock':
        return const Color(0xFFB69E31);
      case 'ghost':
        return const Color(0xFF70559B);
      case 'steel':
        return const Color(0xFFB7B9D0);
      case 'water':
        return const Color(0xFF6493EB);
      case 'grass':
        return const Color(0xFF74CB48);
      case 'psychic':
        return const Color(0xFFFB5584);
      case 'ice':
        return const Color(0xFF9AD6DF);
      case 'dark':
        return const Color(0xFF75574C);
      case 'fairy':
        return const Color(0xFFE69EAC);
      case 'normal':
        return const Color(0xFFAAA67F);
      case 'fighting':
        return const Color(0xFFC12239);
      case 'flying':
        return const Color(0xFFA891EC);
      case 'poison':
        return const Color(0xFFA43E9E);
      case 'ground':
        return const Color(0xFFDEC16B);
      case 'bug':
        return const Color(0xFFA7B723);
      case 'fire':
        return const Color(0xFFF57D31);
      case 'electric':
        return const Color(0xFFF9CF30);
      case 'dragon':
        return const Color(0xFF7037FF);
    }
    return null;
  }
}
