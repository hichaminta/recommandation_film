import 'package:flutter/material.dart';
import 'package:recommandation_film/screens/detailsscreen.dart';
import 'package:recommandation_film/screens/home_screen.dart';
import 'package:recommandation_film/data/movie.dart';
import 'package:recommandation_film/screens/populaires.dart';
import 'package:recommandation_film/screens/totufilms.dart';
import 'package:recommandation_film/screens/toutgenres.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Film Recommendation",
      debugShowCheckedModeBanner: false,

      // Définir la page d'accueil
      home: toutgenres(genreslists: genresList),

      // Routes nommées fixes (si besoin)
      routes: {
        '/home': (context) => HomeScreen(),
        '/films': (context) => Toutfilm(Listesfilmes: listoutfilms,), // Passer une liste vide ici ou une vraie liste de films
        '/populaire_films': (context) => populaires(Listesfilmespopuplaire: listPopulaireMovie,), // Passer une liste vide ici ou une vraie liste de films
      },

      // Route dynamique : pour la page de détails avec un argument
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final movie = settings.arguments as MovieModel;
          return MaterialPageRoute(
            builder: (context) => detaillefilm(movieModel: movie),
          );
        }
        // Si la route n’est pas trouvée
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
      },
    );
  }
}
