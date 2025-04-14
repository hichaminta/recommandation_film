import 'package:flutter/material.dart';
import 'package:recommandation_film/data/movie.dart';
import 'package:recommandation_film/screens/film_par_genre.dart';

class genrewidget extends StatelessWidget {
  final GenreModel genre;

  genrewidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Lorsqu'un genre est cliqué, on passe à la page des films par genre
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FilmsParGenrePage(genre: genre),  // Passe le genre sélectionné à la nouvelle page
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(genre.image.toString()),
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 30),
          ),
          Positioned(
            child: Text(
              genre.name.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            bottom: 0,
            left: 20,
          ),
        ],
      ),
    );
  }
}
