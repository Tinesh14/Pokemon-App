import 'package:flutter/material.dart';
import 'package:poke_app/modules/network/services_network.dart';

import 'package:provider/provider.dart';

abstract class IHomeRepository {
  Future getAllPokemons(int limit, int offset);
  Future pokemonItem(String name);
}

class HomeRepository implements IHomeRepository {
  BuildContext context;

  HomeRepository(this.context);

  @override
  Future getAllPokemons(int limit, int offset) async {
    return await Provider.of<Network>(context, listen: false)
        .getPokemonsList(limit, offset);
  }

  @override
  Future pokemonItem(String name) async {
    return await Provider.of<Network>(context, listen: false).getPokemon(name);
  }
}
