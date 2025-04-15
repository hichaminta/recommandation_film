import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cardfilm extends StatefulWidget {
  final MovieModel movie;

  const Cardfilm({super.key, required this.movie});

  @override
  _CardfilmState createState() => _CardfilmState();
}

class _CardfilmState extends State<Cardfilm> {
  bool isLiked = false;
  
  @override
  void initState() {
    super.initState();
    // Check if movie is liked when the widget initializes
    _checkIfLiked();
  }
  
  // Check if movie is liked using SharedPreferences
  Future<void> _checkIfLiked() async {
    final prefs = await SharedPreferences.getInstance();
    // Get the list of liked movie IDs (or empty list if none)
    final likedMovies = prefs.getStringList('likedMovies') ?? [];
    
    setState(() {
      isLiked = likedMovies.contains(widget.movie.id);
    });
  }
  
  // Update liked status in SharedPreferences
  Future<void> _toggleLikeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Get current list of liked movies
    final likedMovies = prefs.getStringList('likedMovies') ?? [];
    
    setState(() {
      if (isLiked) {
        // Remove from liked movies
        likedMovies.remove(widget.movie.id);
      } else {
        // Add to liked movies
        likedMovies.add(widget.movie.id);
      }
      // Update local state
      isLiked = !isLiked;
    });
    
    // Save updated list back to SharedPreferences
    await prefs.setStringList('likedMovies', likedMovies);
    
    // Show feedback to user
    if (!mounted) return;
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
  }

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
                image: NetworkImage(widget.movie.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Bouton like avec coeur
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(
                isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: isLiked ? Colors.red : Colors.white,
                size: 24,
              ),
              onPressed: _toggleLikeStatus,
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