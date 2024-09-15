import 'package:flutter/material.dart';
import 'pokemonService.dart';
import 'PokemonDetailPage/pokemonDetail.dart';
import 'PokemonModel/pokemonModel.dart';
import 'pokemonCell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon List Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PokemonListPage(),
    );
  }
}

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final PokemonService _pokemonService = PokemonService();
  List<PokemonListItem> _pokemonList = [];
  bool _isLoading = false;
  int _offset = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadPokemonList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadPokemonList(offset: _offset); // Load more Pokémon when reaching the bottom
    }
  }

  Future<void> _loadPokemonList({int limit = 20, int offset = 0}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _pokemonService.getPokemonList(limit: limit, offset: offset);
      setState(() {
        _pokemonList += response.results;
        _offset += limit;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading Pokemon list: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.black, 
      body: _isLoading && _pokemonList.isEmpty
          ? const Center(child: CircularProgressIndicator())
           : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              controller: _scrollController, 
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, 
              ),
              itemCount: _pokemonList.length + 1, // +1 for the loading indicator
              itemBuilder: (context, index) {
                if (index == _pokemonList.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final pokemon = _pokemonList[index];
                return PokemonCell(
                  pokemon: PokemonCellModel(
                    name: pokemon.name,
                    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png', 
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => 
                        PokemonDetailPage(name: pokemon.name),
                      ),
                    );
                  },
                );
              },
            ),
          ),
    );
  }
}
