
class PokemonListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItem> results;

  PokemonListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((item) => PokemonListItem.fromJson(item))
          .toList(),
    );
  }
}

class PokemonListItem {
  final String name;
  final String url;

  PokemonListItem({
    required this.name,
    required this.url,
  });

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'],
      url: json['url'],
    );
  }
}

class PokemonData {
  final PokemonListItem? species;
  final Sprites? sprites;
  final int? height;
  final int? weight;
  final int? baseExperience;
  final List<Stats>? stats;
  final List<Types>? types;

  PokemonData({
    this.species,
    this.sprites,
    this.height,
    this.weight,
    this.baseExperience,
    this.stats,
    this.types,
  });

  factory PokemonData.fromJson(Map<String, dynamic> json) {
    return PokemonData(
      species: json['species'] != null ? PokemonListItem.fromJson(json['species']) : null,
      sprites: json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null,
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'],
      stats: (json['stats'] as List)
          .map((item) => Stats.fromJson(item))
          .toList(),
      types: (json['types'] as List)
          .map((item) => Types.fromJson(item))
          .toList(),
    );
  }
}

class Types {
  final int? slot;
  final PokemonListItem? type;

  Types({
    this.slot,
    this.type,
  });

  factory Types.fromJson(Map<String, dynamic> json) {
    return Types(
      slot: json['slot'],
      type: json['type'] != null ? PokemonListItem.fromJson(json['type']) : null,
    );
  }
}

class Stats {
  final int? baseStat;
  final int? effort;
  final PokemonListItem? stats;

  Stats({
    this.baseStat,
    this.effort,
    this.stats,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stats: json['stats'] != null ? PokemonListItem.fromJson(json['stats']) : null,
    );
  }
}


class Sprites {
  final String front;
  final String frontShiny;
  final String back;
  final String backShiny;

  Sprites({
    required this.front,
    required this.back,
    required this.frontShiny,
    required this.backShiny,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      front: json['front_default'],
      frontShiny: json['front_shiny'],
      back: json['back_default'],
      backShiny: json['back_shiny'],
    );
  }
}

class PokemonBerry {
  final int growthTime;
  final String name;

  PokemonBerry({
    required this.growthTime,
    required this.name,
  });

  factory PokemonBerry.fromJson(Map<String, dynamic> json) {
    return PokemonBerry(
      growthTime: json['growth_time'],
      name: json['name'],
    );
  }
}