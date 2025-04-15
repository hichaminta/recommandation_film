import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/screens/Filmsrecommande.dart';
import 'package:recommandation_film/screens/detailsscreen.dart';
import 'package:recommandation_film/screens/filmsfavorise.dart';
import 'package:recommandation_film/screens/home_screen.dart';
import 'package:recommandation_film/screens/populaires.dart';
import 'package:recommandation_film/screens/totufilms.dart';
import 'package:recommandation_film/screens/toutgenres.dart';
import 'package:recommandation_film/utile/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      home: HomeScreen(), 
      routes: {
        '/home': (context) => HomeScreen(),
        '/films': (context) => FilmLoader(),
        '/populaire_films': (context) => PopularFilmLoader(),
        '/genres': (context) => GenrePageLoader(),
        '/filmsfavorise': (context) => FilmFavorisLoader(),
        '/filmsrecommandes': (context) => FilmRecloaderall(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final movie = settings.arguments as MovieModel;
          return MaterialPageRoute(
            builder: (context) => detaillefilm(movieModel: movie),
          );
        }
        return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text(style:TextStyle(color: appButtonColor), "Route not found"))),
        );
      },
    );
  }
}

// ---- LOADER POUR CHAQUE ÉCRAN ----

class GenreLoader extends StatelessWidget {
  GenreLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GenreModel>>(
      future: fetchGenres(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return myLoader();
        }
        if (snapshot.hasError) {
          return Scaffold(backgroundColor: appBackgroundColor, body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Erreur : ${snapshot.error}')));
        }
        if (snapshot.hasData) {
          return HomeScreen();
        }
        return Scaffold(backgroundColor: appBackgroundColor, body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Aucun genre trouvé')));
      },
    );
  }
}

class GenrePageLoader extends StatelessWidget {
  GenrePageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GenreModel>>(
      future: fetchGenres(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return myLoader();
        }
        if (snapshot.hasError) {
          return Scaffold(backgroundColor: appBackgroundColor, body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Erreur : ${snapshot.error}')));
        }
        if (snapshot.hasData) {
          return toutgenres(genreslists: snapshot.data!);
        }
        return Scaffold(backgroundColor: appBackgroundColor, body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Aucun genre trouvé')));
      },
    );
  }
}

class FilmLoader extends StatelessWidget {
  FilmLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: fetchAllMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return myLoader();
        }
        if (snapshot.hasError) {
          return Scaffold(backgroundColor: appBackgroundColor, body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Erreur : ${snapshot.error}')));
        }
        if (snapshot.hasData) {
          return Toutfilm(Listesfilmes: snapshot.data!);
        }
        return Scaffold(body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Aucun film trouvé')));
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
          return myLoader();
        }
        if (snapshot.hasError) {
          return Scaffold(backgroundColor: appBackgroundColor, body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Erreur : ${snapshot.error}')));
        }
        if (snapshot.hasData) {
          return populaires(Listesfilmespopuplaire: snapshot.data!);
        }
        return Scaffold(
          appBar: AppBar(backgroundColor: appSearchbarColor,title: Text(style:TextStyle(color: appButtonColor), "Films populaire")),
          body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Aucun film populaire trouvé')));
      },
    );
  }
}

// ---- NOUVEAU LOADER POUR LES FILMS FAVORIS ----

class FilmFavorisLoader extends StatelessWidget {
  FilmFavorisLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: fetchLikedMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return myLoader();
        }

        if (snapshot.hasError) {
          return Scaffold(backgroundColor: appBackgroundColor, body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Erreur : ${snapshot.error}')));
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return filmfavorise(Listesfilmes: snapshot.data!);
        }

        return Scaffold(
          appBar: AppBar(backgroundColor: appSearchbarColor,title: Text(style:TextStyle(color: appButtonColor), "Films Favoris")),
          backgroundColor: appBackgroundColor,
          body: Center( child: Text(style:TextStyle(color: appButtonColor), 'Aucun film favori pour le moment')),
        );
      },
    );
  }
}

class myLoader extends StatelessWidget {
  const myLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: appBackgroundColor,
      body: Center(child: CircularProgressIndicator()));
  }
}

class FilmRecloaderall extends StatelessWidget {
  FilmRecloaderall({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: fetchRecommendationsFromLikedMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return myLoader();
        }

        if (snapshot.hasError) {
          return Scaffold(backgroundColor: appBackgroundColor, body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Erreur : ${snapshot.error}')));
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return  filmrecommande(filmrecmoandes: snapshot.data!);
        }

        return Scaffold(
        appBar: AppBar(backgroundColor: appSearchbarColor,title: Text(style:TextStyle(color: appButtonColor), "Films Recommande")),
          backgroundColor: appBackgroundColor,
          body: Center(child: Text(style:TextStyle(color: appButtonColor), 'Aucun film recommande  pour le moment')),
        );
      },
    );
  }
}
