import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:pokemon_flutter/PokemonModel/pokemonModel.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/';
  final Dio _dio;

  PokemonService() : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<PokemonListResponse> getPokemonList({int limit = 20, int offset = 0}) async {
    try {
      final response = await _dio.get('pokemon', queryParameters: {
        'limit': limit,
        'offset': offset,
      });

      return PokemonListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load Pokémon list: ${e.message}');
    }
  }

  Future<PokemonData> getPokemon({required String pokemon}) async {
    try {
      final response = await _dio.get('pokemon/$pokemon');   
      return PokemonData.fromJson(response.data);


    } on DioException catch (e) {
      throw Exception('無法取得寶可夢: ${e.message}');
    }
  }

  Future<PokemonListResponse> getPokemonRegionList({int limit = 20, int offset = 0}) async {
    try {
      final response = await _dio.get('region', queryParameters: {
        'limit': limit,
        'offset': offset,
      });

      return PokemonListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load Pokémon region list: ${e.message}');
    }
  }

  Future<PokemonBerry> getPokemonBerry({int berryId = 1}) async {
    try {
      final response = await _dio.get('berry/$berryId');  // Correct the URL with berryId

      return PokemonBerry.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load Pokémon berry: ${e.message}');
    }
  }

    Future<Uint8List> downloadImageWithDio(String url) async {
    try {
     final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
      return response.data; 
    } on DioException catch (error) {
      throw Exception('Failed to load Pokémon berry: ${error.message}');
    }
}

}


