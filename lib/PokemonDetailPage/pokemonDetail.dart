import 'package:flutter/material.dart';
import '../pokemonService.dart';
import '../PokemonModel/pokemonModel.dart';
import '../PokemonDetailPage/pokemonImage.dart';
import '../PokemonDetailPage/pokemonInfo.dart';
import '../PokemonDetailPage/pokemonBaseStats.dart';

class PokemonDetailPage extends StatefulWidget {
  final String name;

  const PokemonDetailPage({super.key, required this.name});

  @override
  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late Future<PokemonData> _pokemonData;

  @override
  void initState() {
    super.initState();
    _pokemonData = _loadPokemonData(widget.name);
  }

  Future<PokemonData> _loadPokemonData(String name) async {
    try {
      return await PokemonService().getPokemon(pokemon: name);
    } catch (e) {
      print('就決定是你了...誒等等: $e');
      throw Exception('就決定是你了...誒等等');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: FutureBuilder<PokemonData>(
        future: _pokemonData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final pokemon = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PokemonImage(imageUrl: pokemon.sprites?.front ?? ''),
                  PokemonInfo(
                    name: pokemon.species?.name ?? '',
                    type1: pokemon.types?[0].type?.name ?? '',
                    type2: (pokemon.types?.length ?? 0) > 1 ? (pokemon.types?[1].type?.name ?? '') : '',
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
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}