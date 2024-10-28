import 'package:realm/realm.dart';

part 'pokemonModelRealm.g.dart';

@RealmModel()
class _PokemonQuizData {
  @PrimaryKey()
  late int id;
  late String name;
  late List<String> types; 
}

