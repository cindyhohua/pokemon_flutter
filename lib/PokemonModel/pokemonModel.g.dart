// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemonModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonListResponseImpl _$$PokemonListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PokemonListResponseImpl(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => PokemonListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PokemonListResponseImplToJson(
        _$PokemonListResponseImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

_$PokemonListItemImpl _$$PokemonListItemImplFromJson(
        Map<String, dynamic> json) =>
    _$PokemonListItemImpl(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$PokemonListItemImplToJson(
        _$PokemonListItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

_$PokemonDataImpl _$$PokemonDataImplFromJson(Map<String, dynamic> json) =>
    _$PokemonDataImpl(
      species: json['species'] == null
          ? null
          : PokemonListItem.fromJson(json['species'] as Map<String, dynamic>),
      sprites: json['sprites'] == null
          ? null
          : Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
      height: (json['height'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      baseExperience: (json['base_experience'] as num?)?.toInt(),
      stats: (json['stats'] as List<dynamic>?)
          ?.map((e) => Stats.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => Types.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PokemonDataImplToJson(_$PokemonDataImpl instance) =>
    <String, dynamic>{
      'species': instance.species,
      'sprites': instance.sprites,
      'height': instance.height,
      'weight': instance.weight,
      'base_experience': instance.baseExperience,
      'stats': instance.stats,
      'types': instance.types,
    };

_$TypesImpl _$$TypesImplFromJson(Map<String, dynamic> json) => _$TypesImpl(
      slot: (json['slot'] as num?)?.toInt(),
      type: json['type'] == null
          ? null
          : PokemonListItem.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TypesImplToJson(_$TypesImpl instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type,
    };

_$StatsImpl _$$StatsImplFromJson(Map<String, dynamic> json) => _$StatsImpl(
      baseStat: (json['base_stat'] as num?)?.toInt(),
      effort: (json['effort'] as num?)?.toInt(),
      stats: json['stats'] == null
          ? null
          : PokemonListItem.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StatsImplToJson(_$StatsImpl instance) =>
    <String, dynamic>{
      'base_stat': instance.baseStat,
      'effort': instance.effort,
      'stats': instance.stats,
    };

_$SpritesImpl _$$SpritesImplFromJson(Map<String, dynamic> json) =>
    _$SpritesImpl(
      front: json['front_default'] as String,
      frontShiny: json['front_shiny'] as String,
      back: json['back_default'] as String,
      backShiny: json['back_shiny'] as String,
    );

Map<String, dynamic> _$$SpritesImplToJson(_$SpritesImpl instance) =>
    <String, dynamic>{
      'front_default': instance.front,
      'front_shiny': instance.frontShiny,
      'back_default': instance.back,
      'back_shiny': instance.backShiny,
    };

_$PokemonBerryImpl _$$PokemonBerryImplFromJson(Map<String, dynamic> json) =>
    _$PokemonBerryImpl(
      growthTime: (json['growth_time'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$PokemonBerryImplToJson(_$PokemonBerryImpl instance) =>
    <String, dynamic>{
      'growth_time': instance.growthTime,
      'name': instance.name,
    };
