import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter/PokemonModel/pokemonModel.dart';
import '../pokemonProvider.dart'; 
import 'dart:math';
import '../pokemonTypeSelector.dart';
import 'package:collection/collection.dart';
import 'package:realm/realm.dart';
import 'pokemonModelRealm.dart';

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
  late Realm realm;

  @override
  void initState() {
    super.initState();
    realm = Realm(Configuration.local([PokemonQuizData.schema],schemaVersion: 2));
    _initializeData();
  }

  Future<void> _initializeData() async {
    while (realm.all<PokemonQuizData>().length < 5) {
      try {
        await _generateRandomPokemon();
      } catch (e) {
        if (realm.all<PokemonQuizData>().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('無法獲取資料，請檢查網路')),
        );
        break;
        }
      }
    }
  }

  Future<void> _generateRandomPokemon() async {
    _randomPokemonId = _random.nextInt(151) + 1;
    try {
      final pokemonData = await ref.read(pokemonProvider(_randomPokemonId.toString()).future);
      final imageData = await ref.read(imageProvider('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${_randomPokemonId}.png').future);
      _addPokemonToRealm(pokemonData, imageData);
    } catch (error) {
      if (realm.all<PokemonQuizData>().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('錯誤: $error')),
        );
      } else {
        return;
      }
    }
  }

  void _nextPokemonFromRealm(PokemonQuizData pokemonData) {
        _randomPokemonId = pokemonData.id;
        correctTypes = pokemonData.types
            .map((type) => PokemonType.values.firstWhere(
                  (e) => e.toString().split('.').last == type,
                  orElse: () => PokemonType.normal,
                ))
            .toList();
  }

  void _deleteFirstPokemon() {
  if (realm.all<PokemonQuizData>().isNotEmpty) {
    final oldestPokemon = realm.all<PokemonQuizData>().first;
    realm.write(() {
      realm.delete(oldestPokemon);
    });
  }
}

void _addPokemonToRealm(PokemonData pokemonData, Uint8List imageData) {
  final existingPokemon = realm.all<PokemonQuizData>()
      .where((pokemon) => pokemon.id == pokemonData.id)
      .firstOrNull;

  if (existingPokemon == null) {
    final newPokemonData = PokemonQuizData(
      pokemonData.id ?? 0,
      pokemonData.species?.name ?? 'Unknown',
      imageData,
      types: pokemonData.types
          ?.map((type) => type.type?.name?.getName ?? '')
          .whereType<String>()
          .toList() ?? ["normal"],
    );

    realm.write(() {
      realm.add(newPokemonData);
    });
  }
}


void _submitSelection() {
  final currentPokemon = realm.all<PokemonQuizData>().firstOrNull; 
  if (currentPokemon != null) {
        _randomPokemonId = currentPokemon.id;
        correctTypes = currentPokemon.types
            .map((type) => PokemonType.values.firstWhere(
                  (e) => e.toString().split('.').last == type,
                  orElse: () => PokemonType.normal,
                ))
            .toList();
  }
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
          ? 'Thats right!!'
          : 'Wrong answer! The correct answer is: ${correctTypes.join(', ')}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultMessage)),
      );

      _deleteFirstPokemon();
      _generateRandomPokemon();
      setState(() {
        _selectedTypes.fillRange(0, _selectedTypes.length, false);
      }); 
}

@override
  Widget build(BuildContext context) {
    final currentPokemon = realm.all<PokemonQuizData>().firstOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPokemon != null 
          ? '${currentPokemon.name.toUpperCase()} #${currentPokemon.id}'
          : '加載中...'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (currentPokemon != null) ...[
              Image.memory(
                currentPokemon.imageData,
                height: 200,
                width: 200,
                fit: BoxFit.fitHeight,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/w700d1q75cms.jpg',
                        height: 200,
                        width: 200,
                        fit: BoxFit.fitHeight,
                      );
                },
              ),
              const Text('選擇他的屬性：', style: TextStyle(fontSize: 18)),
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
                child: const Text('提交'),
              ),
            ] else
              const CircularProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _deleteFirstPokemon();
          _generateRandomPokemon();
        },
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.red,
      ),
    );
  }
}
