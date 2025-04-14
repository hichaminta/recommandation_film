import 'package:flutter/material.dart';
import 'package:recommandation_film/screens/home_screen.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      title: "Film Recommendation",
    );
  }
}
