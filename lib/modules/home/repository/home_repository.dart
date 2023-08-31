import 'package:poke_app/modules/home/model/pokemon.dart';

import '../../network/services.dart';
import '../../utils/api.dart';

abstract class IHomeRepository {
  Future<PokemonsModel> getAllPokemons();
  Future<Map<String, dynamic>> pokemonItem(int id);
}

class HomeRepository implements IHomeRepository {
  final DioService _dioService;

  HomeRepository(this._dioService);

  @override
  Future<PokemonsModel> getAllPokemons() async {
    var result = await _dioService.getDio().get(API.REQUEST_POKEMONS_LIST);

    return PokemonsModel.fromJson(result.data);
  }

  @override
  Future<Map<String, dynamic>> pokemonItem(int id) async {
    var result =
        await _dioService.getDio().get(API.REQUEST_POKEMON(id.toString()));
    return result.data;
  }
}
