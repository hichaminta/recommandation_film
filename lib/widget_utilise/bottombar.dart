import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recommandation_film/utile/colors.dart';

List<Map<String, dynamic>> navabottomitems = [
  {'icon': FontAwesomeIcons.house, 'route': '/home'},
  {'icon': FontAwesomeIcons.film, 'route': '/films'},
  {'icon': FontAwesomeIcons.solidHeart, 'route': '/home'},
];

class bottombar extends StatelessWidget {
  final int selectedIndex;

  const bottombar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      left: 25,
      right: 25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
          child: Container(
            color: appSearchbarColor.withOpacity(0.6),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Utilisation de 'onTap' pour naviguer vers la route
                ...navabottomitems.map(
                  (item) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, item['route']);
                    },
                    child: Icon(
                      item['icon'],
                      color:
                          item == navabottomitems[selectedIndex]
                              ? Colors.white
                              : Colors.white54,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
