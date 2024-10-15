import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter/PokemonModel/pokemonModel.dart';
import '../pokemonProvider.dart'; 
import 'dart:math';
import '../pokemonTypeSelector.dart';
import 'package:collection/collection.dart';

class PokemonQuizPage extends ConsumerStatefulWidget {
  const PokemonQuizPage({super.key});

  @override
  _PokemonQuizPageState createState() => _PokemonQuizPageState();
}

class _PokemonQuizPageState extends ConsumerState<PokemonQuizPage> {
  final List<PokemonType> _types = PokemonType.values;

  final List<bool> _selectedTypes = List.generate(PokemonType.values.length, (index) => false);
  final Random _random = Random();
  int _randomPokemonId = 1; 
  List<PokemonType> correctTypes = List.empty();

  @override
  void initState() {
    super.initState();
    _generateRandomPokemon(); 
  }

  void _generateRandomPokemon() {
    setState(() {
      _randomPokemonId = _random.nextInt(151) + 1; 
    });
  }

void _submitSelection() {
  final pokemonAsyncValue = ref.watch(pokemonProvider(_randomPokemonId.toString()));
      List<PokemonType> selectedTypes = [];
      for (int i = 0; i < _types.length; i++) {
        if (_selectedTypes[i]) {
          selectedTypes.add(_types[i]);
        }
      }

      bool isEqual = const SetEquality().equals(
        Set.from(selectedTypes),
        Set.from(correctTypes)
      );

      String resultMessage = isEqual
          ? '完全正確～'
          : '錯誤。正確屬性: ${correctTypes.join(', ')}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultMessage)),
      );

      _generateRandomPokemon();
      setState(() {
        _selectedTypes.fillRange(0, _selectedTypes.length, false);
      }); 
}


  @override
  Widget build(BuildContext context) {
  final pokemonAsyncValue = ref.watch(pokemonProvider(_randomPokemonId.toString()));

 pokemonAsyncValue.when(
    data: (pokemonData) {
      correctTypes = pokemonData.types
          ?.map((type) => type.type?.name)
          .whereType<PokemonType>()
          .toList() ?? [];
    },
    loading: () {},
    error: (error, stack) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    },
 );
  return Scaffold(
    appBar: AppBar(
      title: pokemonAsyncValue.when(
        data: (pokemonData) =>
            Text('${pokemonData.species?.name.toUpperCase()} #$_randomPokemonId'),
        loading: () => const Text('Catching a Pokémon...'),
        error: (error, stack) => const Text('Error'),
      ),
      backgroundColor: Colors.red,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          pokemonAsyncValue.when(
            data: (pokemonData) => Column(
              children: [
                Image.network(
                  pokemonData.sprites?.front ?? '',
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            loading: () => const LinearProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
          const Text('Select its types:', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Expanded(
            child: PokemonTypeSelector(
              types: _types,
              selectedTypes: _selectedTypes,
              onSelectionChanged: (updatedSelection) {
                setState(() {
                  for (int i = 0; i < _selectedTypes.length; i++) {
                    _selectedTypes[i] = updatedSelection[i];
                  }
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: _submitSelection,
            child: const Text('Submit Selection'),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _generateRandomPokemon();
        setState(() {}); 
      },
      child: const Icon(Icons.refresh),
      backgroundColor: Colors.red,
      ),
    );  
  }
}
