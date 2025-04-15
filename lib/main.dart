import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/screens/detailsscreen.dart';
import 'package:recommandation_film/screens/home_screen.dart';
import 'package:recommandation_film/screens/populaires.dart';
import 'package:recommandation_film/screens/totufilms.dart';
import 'package:recommandation_film/screens/toutgenres.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Film Recommendation",
      debugShowCheckedModeBanner: false,
      home: GenreLoader(), // Home page will be loaded after genres are fetched

      routes: {
        '/home': (context) => HomeScreen(),
        '/films': (context) => FilmLoader(),
        '/populaire_films': (context) => PopularFilmLoader(),
        '/genres': (context) => GenrePageLoader(),  // New route for Genres page
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final movie = settings.arguments as MovieModel;
          return MaterialPageRoute(
            builder: (context) => detaillefilm(movieModel: movie),
          );
        }
        return MaterialPageRoute(
          builder: (context) => Scaffold(
              body: Center(child: Text("Route not found"))),
        );
      },
    );
  }
}

// Fetch genres and display them
class GenrePageLoader extends StatelessWidget {
  GenrePageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GenreModel>>(
      future: fetchGenres(), // Fetch genres using the method from model.dart
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (snapshot.hasData) {
          return toutgenres(genreslists: snapshot.data!); // Pass genres to the genres screen
        }

        return Scaffold(body: Center(child: Text('No genres found')));
      },
    );
  }
}

class GenreLoader extends StatelessWidget {
  GenreLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GenreModel>>(
      future: fetchGenres(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (snapshot.hasData) {
          return HomeScreen(); // Navigate to HomeScreen after loading genres
        }

        return Scaffold(
          body: Center(child: Text('No genres found')),
        );
      },
    );
  }
}

class FilmLoader extends StatelessWidget {
  FilmLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: fetchPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        }

        if (snapshot.hasData) {
          return Toutfilm(Listesfilmes: snapshot.data!);
        }

        return Scaffold(body: Center(child: Text('No films found')));
      },
    );
  }
}

class PopularFilmLoader extends StatelessWidget {
  PopularFilmLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: fetchPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        }

        if (snapshot.hasData) {
          return populaires(Listesfilmespopuplaire: snapshot.data!);
        }

        return Scaffold(body: Center(child: Text('No popular movies found')));
      },
    );
  }
}
