import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/utile/colors.dart';

class detaillefilm extends StatelessWidget {
  MovieModel movieModel;
  detaillefilm({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),

                    gradient: LinearGradient(
                      colors: [
                        appBackgroundColor.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movieModel.image.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Partie gauche : titre et date
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieModel.title.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  movieModel.releaseDate.toString(),
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 10), // un petit espace
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    movieModel.voteAverage.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    FontAwesomeIcons.solidStar,
                                    size: 15,
                                    color: Colors.yellow,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // les GENRES de film
                      Wrap(
                        spacing: 8.0, // Espace horizontal entre les tags
                        runSpacing: 10.0, // Espace vertical entre les lignes
                        children:
                            movieModel.genres!.map((genre) {
                              return BuildTag(genre.name!);
                            }).toList(),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: ReadMoreText(
                          movieModel.overview.toString(),
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          moreStyle: TextStyle(color: appButtonColor),
                          lessStyle: TextStyle(color: appButtonColor),
                          style: TextStyle(
                            color: Colors.white70,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildTag(String titre_genre) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: appSearchbarColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        titre_genre,
        style: TextStyle(color: Colors.white38, fontSize: 16),
      ),
    );
  }
}
