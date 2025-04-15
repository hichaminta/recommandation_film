import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/widget_utilise/bottombar.dart';
import 'package:recommandation_film/widget_utilise/genrewifget.dart';
import 'package:recommandation_film/utile/colors.dart';

class toutgenres extends StatefulWidget {
  final List<GenreModel> genreslists;

  toutgenres({super.key, required this.genreslists});

  @override
  State<toutgenres> createState() => _toutgenresState();
}

class _toutgenresState extends State<toutgenres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        title: const Text(
          "Tous les Genres",
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
                itemCount: widget.genreslists.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final genre = widget.genreslists[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GenreWidget(genre: genre),
                        ),
                      );
                    },
                    child: GenreWidget(genre: genre),
                  );
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
