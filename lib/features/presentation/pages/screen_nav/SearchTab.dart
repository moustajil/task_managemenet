import 'package:flutter/material.dart';

class Searchtab extends StatefulWidget {
  const Searchtab({super.key});

  @override
  State<Searchtab> createState() => _SearchtabState();
}

class _SearchtabState extends State<Searchtab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Searche Screen",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}