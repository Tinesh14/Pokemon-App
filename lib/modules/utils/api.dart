// ignore_for_file: non_constant_identifier_names

class API {
  static String REQUEST_POKEMONS_LIST = 'pokemon?limit=20&offset=0';
  static String REQUEST_POKEMON_IMG(int index) =>
      'https://unpkg.com/pokeapi-sprites@2.0.2/sprites/pokemon/other/dream-world/$index.svg';
  static String REQUEST_POKEMON(String name) => 'pokemon/$name';
  static String REQUEST_DESCRIPTION(int id) =>
      'https://pokeapi.co/api/v2/pokemon-species/$id';
}
