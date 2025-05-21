import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GenreModel {
  int id;
  String name;
  String image;

  GenreModel({required this.id, required this.name, required this.image});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    String image_g = 'assets/images/$name.jpeg';
    return GenreModel(id: json['id'], name: name, image: image_g);
  }
}

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
    List<GenreModel> genresList = [];

   if (json.containsKey('genre_ids')) {
  List genreIds = json['genre_ids'];
  for (var id in genreIds) {
    print(genreMap[id]);
    GenreModel genre = genreMap[id] ?? GenreModel(id: id, name: 'Inconnu', image: '');
    genresList.add(genre);
  }
    } 
    String imageUrl = json['poster_path'] ?? '';
    String image =
        imageUrl.isEmpty
            ? 'https://via.placeholder.com/500x750?text=No+Image+Available'
            : 'https://image.tmdb.org/t/p/w500$imageUrl';

    return MovieModel(
      id: json['id'].toString(),
      title: json['title'] ?? 'Titre inconnu',
      genres: genresList,
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: json['vote_average']?.toString() ?? '0.0',
      popularity: json['popularity']?.toString() ?? '0.0',
      posterPath: imageUrl,
      image: image,
    );
  }

  void toJson() {}
}

Future<List<GenreModel>> fetchGenres() async {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final response = await http.get(
    Uri.parse('$baseUrl/genre/movie/list?language=en-US'),
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body)['genres'];
    List<GenreModel> genres =
        jsonData.map((data) => GenreModel.fromJson(data)).toList();
    genreMap = {for (var genre in genres) genre.id: genre};
    return genres;
  } else {
    throw Exception('Failed to load genres');
  }
}

Future<List<MovieModel>> fetchPopularMovies() async {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final response = await http.get(
    Uri.parse('$baseUrl/movie/popular?language=en-US&page=1'),
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var movieList = jsonResponse['results'] as List;
 
    return movieList
        .map((movieData) => MovieModel.fromJson(movieData))
        .toList();
  } else {
    throw Exception('Failed to load popular movies');
  }
}

Future<List<MovieModel>> fetchMoviesByGenre(int genreId) async {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final response = await http.get(
    Uri.parse('$baseUrl/discover/movie?with_genres=$genreId&language=en-US'),
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns',
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

Future<List<MovieModel>> fetchLikedMovies() async {
  final prefs = await SharedPreferences.getInstance();
  final likedIds = prefs.getStringList('likedMovies') ?? [];
  if (likedIds.isEmpty) return [];

  List<MovieModel> likedMovies = [];

  for (String id in likedIds) {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$id?language=en-US'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonMovie = json.decode(response.body);
      final movie = MovieModel.fromJson(jsonMovie);
      likedMovies.add(movie);
    } else {
      print('Erreur pour le film avec ID $id');
    }
  }

  return likedMovies;
}

Future<List<MovieModel>> fetchRecommendationsFromLikedMovies() async {
  final prefs = await SharedPreferences.getInstance();
  final likedIds =
      prefs.getStringList('likedMovies') ??
      []; 
  Set<String> seenMovieIds = {}; 
  List<MovieModel> recommendations = [];

  for (String id in likedIds) {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/recommendations?language=en-US',
      ),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['results'];
      for (var data in jsonData) {
        String movieId = data['id'].toString();
        if (!seenMovieIds.contains(movieId)) {
          seenMovieIds.add(movieId);
          recommendations.add(
            MovieModel.fromJson(data),
          ); 
        }
      }
    } else {
      print(
        'Erreur lors de la récupération des recommandations pour le film $id',
      );
    }
  }

  return recommendations;
}

Future<List<MovieModel>> fetchAllMovies({int maxPages = 10}) async {
  const bearerToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjZhN2M4MjcxZDU3N2JjNzdmMmU1ZDgwY2U0NjlkMCIsIm5iZiI6MTc0NDY3MTMxNS4yNDk5OTk4LCJzdWIiOiI2N2ZkOTI1MzYxYjFjNGJiMzI5OTRmNDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fKG7SaYBn-FtJeMEuZJ6c8D4VjQxYvUJ9ngVxln0zns';
  const baseUrl = 'https://api.themoviedb.org/3/discover/movie';
  List<MovieModel> allMovies = [];

  for (int page = 1; page <= maxPages; page++) {
    final uri = Uri.parse(
      baseUrl,
    ).replace(queryParameters: {'language': 'en-US', 'page': page.toString()});



    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List results = data['results'] ?? [];
        print('Films trouvés sur page $page: ${results.length}');

        allMovies.addAll(results.map((e) => MovieModel.fromJson(e)).toList());
      } else {
        print("Erreur API (page $page): ${response.statusCode}");
        break;
      }
    } catch (e) {
      print("Erreur lors de la récupération des films (page $page): $e");
      break;
    }
  }

  print("Total de films récupérés : ${allMovies.length}");
  return allMovies;
}
