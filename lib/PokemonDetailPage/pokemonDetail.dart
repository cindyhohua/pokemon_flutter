import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter/PokemonModel/pokemonModel.dart';
import 'package:pokemon_flutter/main.dart';
import '../pokemonProvider.dart';
import '../PokemonDetailPage/pokemonImage.dart';
import '../PokemonDetailPage/pokemonInfo.dart';
import '../PokemonDetailPage/pokemonBaseStats.dart';

class PokemonDetailPage extends ConsumerWidget {
  final String name;

  const PokemonDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用 ref.watch 來監聽 pokemonProvider 的資料
    final pokemonAsyncValue = ref.watch(pokemonProvider(name));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: pokemonAsyncValue.when(
        data: (pokemon) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PokemonImage(imageUrl: pokemon.sprites?.front ?? ''),
              PokemonInfo(
                name: pokemon.species?.name ?? '',
                type1: pokemon.types?[0].type?.name?.getName ?? '',
                type2: (pokemon.types?.length ?? 0) > 1 ? (pokemon.types?[1].type?.name?.getName ?? '') : '',
                weight: (pokemon.weight?.toDouble() ?? 0) / 10,
                height: (pokemon.height?.toDouble() ?? 0) / 10,
              ),
              PokemonBaseStats(
                hp: pokemon.stats?[0].baseStat ?? 0,
                atk: pokemon.stats?[1].baseStat ?? 0,
                def: pokemon.stats?[2].baseStat ?? 0,
                spd: pokemon.stats?[5].baseStat ?? 0,
                exp: pokemon.baseExperience ?? 0,
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
