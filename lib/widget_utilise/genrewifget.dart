import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/screens/film_par_genre.dart';

class GenreWidget extends StatelessWidget {
  final GenreModel genre;

  GenreWidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    print(genre.image);
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
                image: AssetImage(genre.image ),  // Utiliser une image par défaut si image est nulle
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 30),
          ),
          Positioned(
            child: Text(
              genre.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            top:0 ,
            left: 10,
          ),
        ],
      ),
    );
  }
}
