import 'package:flutter/material.dart' hide Action;
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

  void _performAction(Action action) {
    setState(() {
      session.performAction(action);
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: session.currentActions
                      .map(
                        (action) => switch (action) {
                          NavigationAction() => ElevatedButton.icon(
                              label: Text(action.label),
                              icon: Icon(Icons.arrow_forward),
                              iconAlignment: IconAlignment.end,
                              onPressed: () => _performAction(action),
                            ),
                          _ => throw 'Unknown action type: $action',
                        },
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
