import 'package:flutter/material.dart';
import 'package:pokemon_flutter/PokemonModel/pokemonModel.dart';

class PokemonTypeSelector extends StatefulWidget {
  final List<PokemonType> types;
  final List<bool> selectedTypes;
  final Function(List<bool>) onSelectionChanged;

  const PokemonTypeSelector({
    required this.types,
    required this.selectedTypes,
    required this.onSelectionChanged,
    Key? key,
  }) : super(key: key);

  @override
  _PokemonTypeSelectorState createState() => _PokemonTypeSelectorState();
}

class _PokemonTypeSelectorState extends State<PokemonTypeSelector> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3, 
      ),
      itemCount: widget.types.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.selectedTypes[index] = !widget.selectedTypes[index];
            });
            widget.onSelectionChanged(widget.selectedTypes);
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.selectedTypes[index] ? widget.types[index].color : const Color.fromARGB(255, 72, 72, 72),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.types[index].getName.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
