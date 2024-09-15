import 'package:flutter/material.dart';

class PokemonInfo extends StatelessWidget {
  final String name;
  final String type1;
  final String type2;
  final double weight;
  final double height;

  const PokemonInfo({super.key, 
    required this.name,
    required this.type1,
    required this.type2,
    required this.weight,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTypeChip(type1),
              if (type2.isNotEmpty) ...[
                const SizedBox(width: 8),
                _buildTypeChip(type2),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoText("Weight", "$weight KG"),
              _buildInfoText("Height", "$height M"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    return Chip(
      label: Text(
        type,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: _getTypeColor(type),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.black, width: 1),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case "normal":
        return const Color(0xFFA8A77A);
      case "fire":
        return const Color(0xFFEE8130);
      case "water":
        return const Color(0xFF6390F0);
      case "electric":
        return const Color(0xFFF7D02C);
      case "grass":
        return const Color(0xFF7AC74C);
      case "ice":
        return const Color(0xFF96D9D6);
      case "fighting":
        return const Color(0xFFC22E28);
      case "poison":
        return const Color(0xFFA33EA1);
      case "ground":
        return const Color(0xFFE2BF65);
      case "flying":
        return const Color(0xFFA98FF3);
      case "psychic":
        return const Color(0xFFF95587);
      case "bug":
        return const Color(0xFFA6B91A);
      case "rock":
        return const Color(0xFFB6A136);
      case "ghost":
        return const Color(0xFF735797);
      case "dragon":
        return const Color(0xFF6F35FC);
      case "dark":
        return const Color(0xFF705746);
      case "steel":
        return const Color(0xFFB7B7CE);
      case "fairy":
        return const Color(0xFFD685AD);
      default:
        return Colors.grey;
    }
  }
}
