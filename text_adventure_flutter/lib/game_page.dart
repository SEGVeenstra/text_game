import 'dart:async';

import 'package:flutter/material.dart' hide Action;
import 'package:text_adventure/text_adventure.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
    required this.game,
  });

  final TextAdventureConfiguration game;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final session = TextAdventureSession(
    game: widget.game,
    progress: TextAdventureProgress(),
  );

  late final StreamSubscription _eventsSubscription;

  @override
  void initState() {
    super.initState();
    _eventsSubscription = session.events.listen((event) async {
      if (mounted) {
        await _showDialog(
          context,
          'Event',
          event.message,
        );
      }
    });
  }

  void _performAction(Action action) {
    setState(() {
      session.performAction(action);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Column(
              key: ValueKey(session.currentLocation.id),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(session.currentLocation.name,
                    style: Theme.of(context).textTheme.headlineLarge),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    itemCount: session.currentLocation.description.length,
                    itemBuilder: (context, index) {
                      final description =
                          session.currentLocation.description[index];
                      return Text(description.text);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                  ),
                ),
                Spacer(),
                Wrap(
                  spacing: 16,
                  children: session.inventory.entries
                      .map(
                        (entry) => InputChip(
                          label: Text('${entry.key.name} x${entry.value}'),
                          onPressed: () => _showDialog(
                            context,
                            '${entry.key.name} x${entry.value}',
                            entry.key.description,
                          ),
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
                          icon: Icon(
                            switch (action.type) {
                              ActionType.navigate => Icons.arrow_forward,
                              ActionType.use => Icons.back_hand_outlined,
                            },
                          ),
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

  @override
  void dispose() {
    _eventsSubscription.cancel();
    super.dispose();
  }
}

Future<void> _showDialog(
    BuildContext context, String title, String content) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CLOSE'),
        ),
      ],
    ),
  );
}
