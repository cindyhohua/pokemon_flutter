import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonCellModel {
  final String name;
  final String imageUrl;

  PokemonCellModel({required this.name, required this.imageUrl});
}

class PokemonCell extends StatefulWidget {
  final PokemonCellModel pokemon;
  final VoidCallback onTap;

  const PokemonCell({super.key, required this.pokemon, required this.onTap});

  @override
  _PokemonCellState createState() => _PokemonCellState();
}

class _PokemonCellState extends State<PokemonCell> {
  Color? dominantColor;
  bool _mounted = true;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  Future<void> _updatePalette() async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.pokemon.imageUrl),
    );
    
    if (_mounted) {
      setState(() {
        dominantColor = Color.lerp(paletteGenerator.dominantColor?.color, Colors.white, 0.5) ?? Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: dominantColor ?? Colors.grey, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                widget.pokemon.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.pokemon.name,
              style: const TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
