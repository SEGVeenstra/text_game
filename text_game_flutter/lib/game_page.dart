import 'package:flutter/material.dart';
import 'package:text_game/text_game.dart';
import 'package:text_game_flutter/example_game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final session = TextGameSession(
    game: exampleGame,
    progress: TextGameProgress(),
  );

  void _go(Location exit) {
    setState(() {
      session.go(exit.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Column(
              key: ValueKey(session.currentLocation.id),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(session.currentLocation.name,
                    style: Theme.of(context).textTheme.headlineLarge),
                Text(session.currentLocation.description),
                Spacer(),
                Text('Navigation'),
                Divider(),
                Column(
                  children: session.currentExits
                      .map(
                        (exit) => ListTile(
                          trailing: Icon(Icons.arrow_forward),
                          title: Text(exit.name),
                          onTap: () => _go(exit),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
