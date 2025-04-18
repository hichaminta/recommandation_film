import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/widget_utilise/bottombar.dart';
import 'package:recommandation_film/widget_utilise/cardfilm.dart';
import 'package:recommandation_film/utile/colors.dart';

class filmrecommande extends StatefulWidget {
  final List<MovieModel> filmrecmoandes; // Déclarer filmrecmoandes comme final

  filmrecommande({
    super.key,
    required this.filmrecmoandes,
  }); // Correctement initialiser le constructeur

  @override
  State<filmrecommande> createState() => _filmrecommandeState();
}

class _filmrecommandeState extends State<filmrecommande> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        title: const Text("Pour Vous", style: TextStyle(color: Colors.white)),
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
                        .filmrecmoandes
                        .length, // Accéder à filmrecmoandes avec widget.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Cardfilm(
                    movie: widget.filmrecmoandes[index],
                  ); // Accéder à filmrecmoandes avec widget.
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
