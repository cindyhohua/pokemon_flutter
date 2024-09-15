import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonImage extends StatefulWidget {
  final String imageUrl;

  const PokemonImage({super.key, required this.imageUrl});

  @override
  _PokemonImageState createState() => _PokemonImageState();
}

class _PokemonImageState extends State<PokemonImage> {
  Color backgroundColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _updateBackgroundColor();
  }

  Future<void> _updateBackgroundColor() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.imageUrl),
    );
    setState(() {
      backgroundColor = Color.lerp(generator.dominantColor?.color, Colors.white, 0.5) ?? Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: ClipOval(
          child: Container(
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
