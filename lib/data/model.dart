import 'dart:convert';
import 'package:http/http.dart' as http;

class GenreModel {
  int id;
  String name;
  String image;

  GenreModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    String image_g = 'assets/images/$name.jpeg';
    return GenreModel(
      id: json['id'],
      name: json['name'],
      image: image_g, // Tu peux ajouter une logique pour les images plus tard
    );
  }
}

// Map globale pour stocker les genres disponibles
Map<int, GenreModel> genreMap = {};

class MovieModel {
  String id;
  String title;
  List<GenreModel> genres;
  String overview;
  String releaseDate;
  String voteAverage;
  String popularity;
  String posterPath;
  String image;

  MovieModel({
    required this.id,
    required this.title,
    required this.genres,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.popularity,
    required this.posterPath,
    required this.image,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Utilisation du genreMap pour récupérer les bons noms
    var genresList = (json['genre_ids'] as List)
        .map((id) => genreMap[id] ?? GenreModel(id: id, name: 'Inconnu', image: ''))
        .toList();

    String imageUrl = json['poster_path'] ?? '';
    String image = imageUrl.isEmpty
        ? 'https://via.placeholder.com/500x750?text=No+Image+Available'
        : 'https://image.tmdb.org/t/p/w500$imageUrl';

    return MovieModel(
      id: json['id'].toString(),
      title: json['title'],
      genres: genresList,
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toString(),
      popularity: json['popularity'].toString(),
      posterPath: imageUrl,
      image: image,
    );
  }
}

// Mise à jour de genreMap
Future<List<GenreModel>> fetchGenres() async {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final response = await http.get(
    Uri.parse('$baseUrl/genre/movie/list?language=en-US'),
    headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body)['genres'];
    List<GenreModel> genres = jsonData.map((data) => GenreModel.fromJson(data)).toList();

    // Remplir genreMap global
    genreMap = {for (var genre in genres) genre.id: genre};

    return genres;
  } else {
    throw Exception('Failed to load genres');
  }
}

// Films populaires
Future<List<MovieModel>> fetchPopularMovies() async {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final response = await http.get(
    Uri.parse('$baseUrl/movie/popular?language=en-US&page=1'),
    headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var movieList = jsonResponse['results'] as List;

    return movieList.map((movieData) => MovieModel.fromJson(movieData)).toList();
  } else {
    throw Exception('Failed to load popular movies');
  }
}

//  Films par genre
Future<List<MovieModel>> fetchMoviesByGenre(int genreId) async {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final response = await http.get(
    Uri.parse('$baseUrl/discover/movie?with_genres=$genreId&language=fr-FR'),
    headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body)['results'];
    return jsonData.map((data) => MovieModel.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load movies for genre $genreId');
  }
}
