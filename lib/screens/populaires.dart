import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/widget_utilise/bottombar.dart';
import 'package:recommandation_film/widget_utilise/cardfilm.dart';
import 'package:recommandation_film/utile/colors.dart';

class populaires extends StatefulWidget {
  final List<MovieModel> Listesfilmespopuplaire;  // Déclarer Listesfilmespopuplaire comme final

  populaires({super.key, required this.Listesfilmespopuplaire});  // Correctement initialiser le constructeur

  @override
  State<populaires> createState() => _populairesState();
}

class _populairesState extends State<populaires> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        title: const Text(
          "Populaires Films",
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
                itemCount: widget.Listesfilmespopuplaire.length,  // Accéder à Listesfilmespopuplaire avec widget.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Cardfilm(movie: widget.Listesfilmespopuplaire[index]);  // Accéder à Listesfilmespopuplaire avec widget.
                },
              ),
            ),
          ),
          bottombar(selectedIndex: 1),
        ],
      ),
    );
  }
}
