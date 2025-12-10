import 'package:flutter/material.dart';

class Favoritestab extends StatefulWidget {
  const Favoritestab({super.key});

  @override
  State<Favoritestab> createState() => _FavoritestabState();
}

class _FavoritestabState extends State<Favoritestab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Favorites Screen",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}