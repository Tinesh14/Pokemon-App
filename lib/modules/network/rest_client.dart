import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://pokeapi.co/api/v2/', parser: Parser.JsonSerializable)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("pokemon")
  Future getPokemonsList(
    @Query("limit") int limit,
    @Query("offset") int offset,
  );

  @GET("pokemon/{name}")
  Future getPokemon(
    @Path('name') String name,
  );

  @GET("pokemon-species/{id}")
  Future getPokemonDescription(
    @Path('id') int id,
  );
}

// `flutter pub run build_runner build --delete-conflicting-outputs`

