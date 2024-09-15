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
    PokemonListItem? species,
    Sprites? sprites,
    int? height,
    int? weight,
    int? baseExperience,
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
    PokemonListItem? type,
  }) = _Types;

  factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);
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