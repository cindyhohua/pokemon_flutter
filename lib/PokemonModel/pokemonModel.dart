import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemonModel.freezed.dart';
part 'pokemonModel.g.dart';

@freezed
class PokemonListResponse with _$PokemonListResponse {
  factory PokemonListResponse({
    required int count,
    String? next,
    String? previous,
    required List<PokemonListItem> results,
  }) = _PokemonListResponse;

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseFromJson(json);
}

@freezed
class PokemonListItem with _$PokemonListItem {
  factory PokemonListItem({
    required String name,
    required String url,
  }) = _PokemonListItem;

  factory PokemonListItem.fromJson(Map<String, dynamic> json) =>
      _$PokemonListItemFromJson(json);
}

@freezed
class PokemonData with _$PokemonData {
  factory PokemonData({
    int? id,
    PokemonListItem? species,
    Sprites? sprites,
    int? height,
    int? weight,
    @JsonKey(name: 'base_experience') int? baseExperience,
    List<Stats>? stats,
    List<Types>? types,
  }) = _PokemonData;

  factory PokemonData.fromJson(Map<String, dynamic> json) =>
      _$PokemonDataFromJson(json);
}

@freezed
class Types with _$Types {
  factory Types({
    int? slot,
    PokemonTypeData? type, 
  }) = _Types;

  factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);
}

@freezed
class PokemonTypeData with _$PokemonTypeData {
  factory PokemonTypeData({
    PokemonType? name,
    String? url,
  }) = _PokemonTypeData;

  factory PokemonTypeData.fromJson(Map<String, dynamic> json) => _$PokemonTypeDataFromJson(json);
}

enum PokemonType {
  normal,
  fire,
  water,
  electric,
  grass,
  ice,
  fighting,
  poison,
  ground,
  flying,
  psychic,
  bug,
  rock,
  ghost,
  dragon,
  dark,
  steel,
  fairy,
}

extension PokemonTypeExtension on PokemonType {
  String get getName {
    switch (this) {
      case PokemonType.normal:
        return 'normal';
      case PokemonType.fire:
        return 'fire';
      case PokemonType.water:
        return 'water';
      case PokemonType.electric:
        return 'electric';
      case PokemonType.grass:
        return 'grass';
      case PokemonType.ice:
        return 'ice';
      case PokemonType.fighting:
        return 'fighting';
      case PokemonType.poison:
        return 'poison';
      case PokemonType.ground:
        return 'ground';
      case PokemonType.flying:
        return 'flying';
      case PokemonType.psychic:
        return 'psychic';
      case PokemonType.bug:
        return 'bug';
      case PokemonType.rock:
        return 'rock';
      case PokemonType.ghost:
        return 'ghost';
      case PokemonType.dragon:
        return 'dragon';
      case PokemonType.dark:
        return 'dark';
      case PokemonType.steel:
        return 'steel';
      case PokemonType.fairy:
        return 'fairy';
    }
  }

  Color get color {
    switch (this) {
      case PokemonType.normal:
        return const Color(0xFFA8A77A);
      case PokemonType.fire:
        return const Color(0xFFEE8130);
      case PokemonType.water:
        return const Color(0xFF6390F0);
      case PokemonType.electric:
        return const Color(0xFFF7D02C);
      case PokemonType.grass:
        return const Color(0xFF7AC74C);
      case PokemonType.ice:
        return const Color(0xFF96D9D6);
      case PokemonType.fighting:
        return const Color(0xFFC22E28);
      case PokemonType.poison:
        return const Color(0xFFA33EA1);
      case PokemonType.ground:
        return const Color(0xFFE2BF65);
      case PokemonType.flying:
        return const Color(0xFFA98FF3);
      case PokemonType.psychic:
        return const Color(0xFFF95587);
      case PokemonType.bug:
        return const Color(0xFFA6B91A);
      case PokemonType.rock:
        return const Color(0xFFB6A136);
      case PokemonType.ghost:
        return const Color(0xFF735797);
      case PokemonType.dragon:
        return const Color(0xFF6F35FC);
      case PokemonType.dark:
        return const Color(0xFF705746);
      case PokemonType.steel:
        return const Color(0xFFB7B7CE);
      case PokemonType.fairy:
        return const Color(0xFFD685AD);
      default:
        return Colors.grey;
    }
  }
}


@freezed
class Stats with _$Stats {
  factory Stats({
    @JsonKey(name: 'base_stat') int? baseStat,
    int? effort,
    PokemonListItem? stats,
  }) = _Stats;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}

@freezed
class Sprites with _$Sprites {
  factory Sprites({
    @JsonKey(name: 'front_default') required String front,  
    @JsonKey(name: 'front_shiny') required String frontShiny,
    @JsonKey(name: 'back_default') required String back, 
    @JsonKey(name: 'back_shiny') required String backShiny,
  }) = _Sprites;

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);
}


@freezed
class PokemonBerry with _$PokemonBerry {
  factory PokemonBerry({
    @JsonKey(name: 'growth_time') required int growthTime,
    required String name,
  }) = _PokemonBerry;

  factory PokemonBerry.fromJson(Map<String, dynamic> json) =>
      _$PokemonBerryFromJson(json);
}