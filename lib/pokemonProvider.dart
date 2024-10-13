import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pokemonService.dart';
import '../PokemonModel/pokemonModel.dart';

final pokemonProvider = FutureProvider.family<PokemonData, String>((ref, name) async {
  final service = PokemonService();
  return await service.getPokemon(pokemon: name);
});
