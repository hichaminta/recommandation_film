import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/screens/totufilms.dart';

class FilmsParGenrePage extends StatefulWidget {
  final GenreModel genre;

  FilmsParGenrePage({super.key, required this.genre});

  @override
  _FilmsParGenrePageState createState() => _FilmsParGenrePageState();
}

class _FilmsParGenrePageState extends State<FilmsParGenrePage> {
  late Future<List<MovieModel>> _films;

  @override
  void initState() {
    super.initState();
    // Récupérer les films du genre sélectionné
    _films = fetchMoviesByGenre(widget.genre.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.genre.name)),
      body: FutureBuilder<List<MovieModel>>(
        future: _films,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun film trouvé pour ce genre.'));
          } else {
            List<MovieModel> films = snapshot.data!;
            return Toutfilm(Listesfilmes: films); // Affichage des films filtrés
          }
        },
      ),
    );
  }
}
