import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/widget_utilise/bottombar.dart';
import 'package:recommandation_film/widget_utilise/cardfilm.dart';
import 'package:recommandation_film/utile/colors.dart';

class filmfavorise extends StatefulWidget {
  final List<MovieModel> Listesfilmes; // Déclarer Listesfilmes comme final

  filmfavorise({
    super.key,
    required this.Listesfilmes,
  }); // Correctement initialiser le constructeur

  @override
  State<filmfavorise> createState() => _filmfavoriseState();
}

class _filmfavoriseState extends State<filmfavorise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        title: const Text(
          "Films favoris",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: GridView.builder(
                itemCount:
                    widget
                        .Listesfilmes
                        .length, // Accéder à Listesfilmes avec widget.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Cardfilm(
                    movie: widget.Listesfilmes[index],
                  ); // Accéder à Listesfilmes avec widget.
                },
              ),
            ),
          ),
          bottombar(selectedIndex: 2),
        ],
      ),
    );
  }
}
