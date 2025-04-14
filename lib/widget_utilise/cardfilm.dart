import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recommandation_film/data/movie.dart';

class Cardfilm extends StatefulWidget {
  final MovieModel movie;

  const Cardfilm({super.key, required this.movie});

  @override
  _CardfilmState createState() => _CardfilmState();
}

class _CardfilmState extends State<Cardfilm> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: widget.movie);
      },
      child: Stack(
        children: [
          // Image du film
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 200,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: AssetImage(widget.movie.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // aimer l'image
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.heart,
                color: isLiked ? Colors.red : Colors.white,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isLiked ? 'Film liked!' : 'Film unliked!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: isLiked ? Colors.green : Colors.grey,
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),

          // Infos film
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
                        widget.movie.title.toString(),
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.movie.releaseDate.toString(),
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
                      widget.movie.voteAverage!,
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
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
