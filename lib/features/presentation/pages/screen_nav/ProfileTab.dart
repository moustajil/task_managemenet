import 'package:flutter/material.dart';

class Profiletab extends StatefulWidget {
  const Profiletab({super.key});

  @override
  State<Profiletab> createState() => _ProfiletabState();
}

class _ProfiletabState extends State<Profiletab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Profile Screen",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}