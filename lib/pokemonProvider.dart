import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pokemonService.dart';
import '../PokemonModel/pokemonModel.dart';
import 'package:realm/realm.dart';
import 'pokemonModelRealm.dart';

final pokemonProvider = FutureProvider.family<PokemonData, String>((ref, name) async {
  final service = PokemonService();
  return await service.getPokemon(pokemon: name);
});

final imageProvider = FutureProvider.family<Uint8List, String>((ref, imageUrl) async {
  final service = PokemonService();
  return await service.downloadImageWithDio(imageUrl);
});

final firstPokemonQuizDataProvider = FutureProvider<PokemonQuizData?>((ref) async {
  final realm = Realm(Configuration.local([PokemonQuizData.schema], schemaVersion: 2));
  final firstPokemon = realm.all<PokemonQuizData>().isNotEmpty 
      ? realm.all<PokemonQuizData>().first 
      : null;
  return firstPokemon;
});