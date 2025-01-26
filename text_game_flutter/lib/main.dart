import 'package:flutter/material.dart';
import 'package:text_game_flutter/game_page.dart';

void main() {
  runApp(const TextGameApp());
}

class TextGameApp extends StatelessWidget {
  const TextGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GamePage(),
    );
  }
}
