import 'package:flutter/material.dart';
import 'pokemonService.dart';
import 'PokemonDetailPage/pokemonDetail.dart';
import 'PokemonModel/pokemonModel.dart';
import 'pokemonCell.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pokemonQuizPage.dart';

void main() {
  runApp(
    ProviderScope(  
      child: const MyApp(),
    ),
  );
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
      home: const MainPage(),  
    );
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PokemonListPage(),
    const PokemonQuizPage(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.view_array_rounded), label: 'Pokedex'),
    BottomNavigationBarItem(icon: Icon(Icons.create), label: 'Pokequiz'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 255, 100, 100),
        unselectedItemColor: const Color.fromARGB(255, 167, 150, 150),
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
        currentIndex: _currentIndex,
        items: _navItems,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
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
