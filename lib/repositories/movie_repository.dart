import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieRepository {
  final String baseUrl = "https://api.tvmaze.com/search/shows?q=";

  Future<List<Movie>> fetchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl$query'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
