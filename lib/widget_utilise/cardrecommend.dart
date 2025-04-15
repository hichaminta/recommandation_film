import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/utile/colors.dart';

class CardRecommend extends StatelessWidget {
  MovieModel mv;
  CardRecommend({super.key, required this.mv});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: mv);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: appBackgroundColor.withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(mv.image.toString()),
            fit: BoxFit.cover,
          ),
        ),
        margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
      ),
    );
  }
}
