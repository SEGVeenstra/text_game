import 'package:flutter/material.dart';
import 'package:text_adventure_flutter/example_game.dart';
import 'package:text_adventure_flutter/example_mistery.dart';
import 'package:text_adventure_flutter/game_meta_page.dart';

class GameCollectionPage extends StatelessWidget {
  const GameCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Example'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GameMetaPage(game: exampleGame))),
          ),
          ListTile(
            title: const Text('Mistery'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GameMetaPage(game: misteryExample))),
          ),
        ],
      ),
    );
  }
}
