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
    String name,
    Uint8List imageData, {
    Iterable<String> types = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<String>>(
        this, 'types', RealmList<String>(types));
    RealmObjectBase.set(this, 'imageData', imageData);
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
  Uint8List get imageData =>
      RealmObjectBase.get<Uint8List>(this, 'imageData') as Uint8List;
  @override
  set imageData(Uint8List value) =>
      RealmObjectBase.set(this, 'imageData', value);

  @override
  Stream<RealmObjectChanges<PokemonQuizData>> get changes =>
      RealmObjectBase.getChanges<PokemonQuizData>(this);

  @override
  Stream<RealmObjectChanges<PokemonQuizData>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<PokemonQuizData>(this, keyPaths);

  @override
  PokemonQuizData freeze() =>
      RealmObjectBase.freezeObject<PokemonQuizData>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'types': types.toEJson(),
      'imageData': imageData.toEJson(),
    };
  }

  static EJsonValue _toEJson(PokemonQuizData value) => value.toEJson();
  static PokemonQuizData _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'imageData': EJsonValue imageData,
      } =>
        PokemonQuizData(
          fromEJson(id),
          fromEJson(name),
          fromEJson(imageData),
          types: fromEJson(ejson['types']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(PokemonQuizData._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, PokemonQuizData, 'PokemonQuizData', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('types', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('imageData', RealmPropertyType.binary),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
