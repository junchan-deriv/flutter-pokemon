import 'package:flutter/material.dart';
import 'package:pikachu_jump/main_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Pikachu Jump",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MainPage(),
    ),
  );
}
