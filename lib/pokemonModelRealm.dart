import 'dart:typed_data';
import 'package:realm/realm.dart';

part 'pokemonModelRealm.realm.dart';

@RealmModel()
class _PokemonQuizData {
  @PrimaryKey()
  late int id;
  late String name;
  late List<String> types; 
  late Uint8List imageData;
}

