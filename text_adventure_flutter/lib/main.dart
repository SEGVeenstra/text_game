import 'package:flutter/material.dart';
import 'package:text_adventure_flutter/game_collection_page.dart';
import 'package:text_adventure_flutter/theme/text_game_theme.dart';

void main() {
  runApp(const TextGameApp());
}

class TextGameApp extends StatelessWidget {
  const TextGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: textGameTheme,
      home: GameCollectionPage(),
    );
  }
}
