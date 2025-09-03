import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  static Future<List<Pokemon>> getPokemonList({int limit = 20, int offset = 0}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        
        List<Pokemon> pokemonList = [];
        for (var result in results) {
          final pokemonResponse = await http.get(Uri.parse(result['url']));
          if (pokemonResponse.statusCode == 200) {
            final pokemonData = json.decode(pokemonResponse.body);
            pokemonList.add(Pokemon.fromJson(pokemonData));
          }
        }
        return pokemonList;
      } else {
        throw Exception('Failed to load Pokemon');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Pokemon> getPokemonDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Pokemon.fromJson(data);
      } else {
        throw Exception('Failed to load Pokemon details');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

class Pokemon {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'].toString())
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'].toString())
          .toList(),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ?? 
                json['sprites']['front_default'] ?? '',
    );
  }

  String get capitalizedName => name[0].toUpperCase() + name.substring(1);
}
