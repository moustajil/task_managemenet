import 'package:flutter/material.dart';

class GolasTAp extends StatefulWidget {
  const GolasTAp({super.key});

  @override
  State<GolasTAp> createState() => _FavoritestabState();
}

class _FavoritestabState extends State<GolasTAp> {
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