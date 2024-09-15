import 'package:flutter/material.dart';

class PokemonBaseStats extends StatelessWidget {
  final int hp;
  final int atk;
  final int def;
  final int spd;
  final int exp;

  const PokemonBaseStats({super.key, 
    required this.hp,
    required this.atk,
    required this.def,
    required this.spd,
    required this.exp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Base Stats", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, 
              fontSize: 24
              )
            ),
          const SizedBox(height: 10),
          _buildStatBar("HP", hp, 300, Colors.red),
          _buildStatBar("ATK", atk, 300, Colors.orange),
          _buildStatBar("DEF", def, 300, Colors.blue),
          _buildStatBar("SPD", spd, 300, Colors.lightBlue),
          _buildStatBar("EXP", exp, 1000, Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, int value, int maxValue, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(label, style: const TextStyle(color: Colors.white)),
        ),
        Expanded(
          child: SizedBox(
            height: 10, 
            child: LinearProgressIndicator(
              value: value / maxValue,
              color: color,
              backgroundColor: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            "$value/$maxValue", 
            style: const TextStyle(color: Colors.white), 
            textAlign: TextAlign.end,
            ),
        )
      ],
    );
  }
}
