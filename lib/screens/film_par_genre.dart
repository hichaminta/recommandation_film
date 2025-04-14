import 'package:flutter/material.dart';
import 'package:recommandation_film/data/movie.dart';
import 'package:recommandation_film/screens/totufilms.dart';

class FilmsParGenrePage extends StatelessWidget {
  final GenreModel genre;

  FilmsParGenrePage({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    // Filtrer les films par genre
    List<MovieModel> filmsFiltres = listoutfilms.where((film) {
      // Vérifier si le genre est dans la liste des genres du film
      return film.genres?.any((g) => g.name == genre.name) ?? false;
    }).toList();

    // Afficher la liste des films filtrés dans Toutfilm
    return Toutfilm(Listesfilmes: filmsFiltres);
  }
}
