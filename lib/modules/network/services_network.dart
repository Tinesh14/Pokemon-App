import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:poke_app/modules/network/rest_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Network {
  late RestClient client;
  static final Network _network = Network._internal();

  Network._internal();

  factory Network() {
    _network.client = _network.getRestClient();
    return _network;
  }

  RestClient getRestClient() {
    // var _prettyDioLogger = PrettyDioLogger(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseBody: true,
    //   responseHeader: false,
    //   error: true,
    //   compact: true,
    //   maxWidth: 90,
    // );
    final dio =
        Dio(BaseOptions(connectTimeout: 1000 * 60, receiveTimeout: 1000 * 60));
    // if (!kReleaseMode) {
    //   dio.interceptors.add(_prettyDioLogger);
    // }
    return RestClient(dio, baseUrl: 'https://pokeapi.co/api/v2/');
  }

  Future getPokemonsList(int limit, int offset) async {
    return client.getPokemonsList(limit, offset);
  }

  Future getPokemon(String name) async {
    return client.getPokemon(name);
  }

  Future getPokemonDescription(int id) async {
    return client.getPokemonDescription(id);
  }
}
