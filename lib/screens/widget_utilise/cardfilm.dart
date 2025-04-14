import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recommandation_film/data/movie.dart';

class Cardfilm extends StatelessWidget {
  MovieModel movie;
  Cardfilm({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),

          height: 200,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: AssetImage(movie.image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 15,
          right: 15,
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      movie.title.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      movie.releaseDate.toString(),
                      maxLines: 1,

                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    movie.voteAverage!,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
