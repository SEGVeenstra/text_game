import 'package:flutter/material.dart';
import 'package:text_game/text_game.dart';
import 'package:text_game_flutter/game_page.dart';

class GameMetaPage extends StatelessWidget {
  const GameMetaPage({
    super.key,
    required this.game,
  });

  final TextGameConfiguration game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.meta.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(game.meta.description),
              Text('Made by: ${game.meta.author}'),
              Text('version: ${game.meta.version}'),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GamePage(game: game)));
                },
                child: const Text('Play'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
