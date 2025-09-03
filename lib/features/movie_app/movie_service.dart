import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '58040eab563a5febf490af8acce15b8f'; // Replace with actual API key
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<MovieDetails> getMovieDetails(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieDetails.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
    );
  }

  String get fullPosterUrl => '${MovieService.imageBaseUrl}$posterPath';
  String get fullBackdropUrl => '${MovieService.imageBaseUrl}$backdropPath';
}

class MovieDetails extends Movie {
  final int runtime;
  final List<String> genres;
  final String tagline;

  MovieDetails({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.backdropPath,
    required super.voteAverage,
    required super.releaseDate,
    required this.runtime,
    required this.genres,
    required this.tagline,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List?)?.map((g) => g['name'].toString()).toList() ?? [],
      tagline: json['tagline'] ?? '',
    );
  }
}
