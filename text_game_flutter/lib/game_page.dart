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
                Wrap(
                  spacing: 16,
                  children: session.inventory.entries
                      .map(
                        (entry) => Chip(
                          label: Text('${entry.key.name} x${entry.value}'),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: session.currentActions
                      .map(
                        (action) => ElevatedButton.icon(
                          label: Text(action.label),
                          icon: Icon(switch (action.type) {
                            ActionType.navigate => Icons.arrow_forward,
                            ActionType.use => Icons.back_hand_outlined,
                          }),
                          iconAlignment: IconAlignment.end,
                          onPressed: () => _performAction(action),
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
