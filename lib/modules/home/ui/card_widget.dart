import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_app/config/routes/routes.dart';
import 'package:poke_app/modules/detail/ui/detail_card_widget.dart';

import '../../utils/api.dart';

class PokemonCardWidget extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  const PokemonCardWidget({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstData = (pokemon['types'] as List).first;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          PageRoutes.detail,
          arguments: pokemon,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF74CB48)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 4),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  '#${pokemon['id'].toString().padLeft(3, '0')}',
                  style: const TextStyle(fontSize: 8, color: Color(0xFF74CB48)),
                ),
              ),
            ),
            SizedBox(
              width: 72,
              height: 72,
              child: Hero(
                tag: pokemon['id'],
                child: SvgPicture.network(
                  'https://unpkg.com/pokeapi-sprites@2.0.2/sprites/pokemon/other/dream-world/${pokemon['id']}.svg',
                  placeholderBuilder: ((context) {
                    return Container(
                        padding: const EdgeInsets.all(16),
                        child: const CircularProgressIndicator());
                  }),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  (pokemon['name'] as String? ?? '').toFirstLetterCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 24,
              decoration: BoxDecoration(
                color: StatsNames.color(type: firstData['type']['name']),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toFirstLetterCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
