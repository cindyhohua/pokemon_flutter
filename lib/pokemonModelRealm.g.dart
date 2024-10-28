// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemonModelRealm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PokemonQuizData extends _PokemonQuizData
    with RealmEntity, RealmObjectBase, RealmObject {
  PokemonQuizData(
    int id,
    String name, {
    Iterable<String> types = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<String>>(
        this, 'types', RealmList<String>(types));
  }

  PokemonQuizData._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<String> get types =>
      RealmObjectBase.get<String>(this, 'types') as RealmList<String>;
  @override
  set types(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<PokemonQuizData>> get changes =>
      RealmObjectBase.getChanges<PokemonQuizData>(this);

  @override
  PokemonQuizData freeze() =>
      RealmObjectBase.freezeObject<PokemonQuizData>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PokemonQuizData._);
    return const SchemaObject(
        ObjectType.realmObject, PokemonQuizData, 'PokemonQuizData', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('types', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
