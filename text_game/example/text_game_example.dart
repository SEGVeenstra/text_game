import 'package:text_game/text_game.dart';

void main() {
  final locations = [
    LocationConfiguration(
      id: 'roomA',
      name: 'Room A',
      description: 'You are in room A.',
      actions: [
        NavigationActionConfiguration(
          label: 'To room B',
          effects: [],
          locationId: 'roomB',
        ),
      ],
    ),
    LocationConfiguration(
      id: 'roomB',
      name: 'Room B',
      description: 'You are in room B.',
      actions: [
        NavigationActionConfiguration(
          label: 'To room A',
          effects: [],
          locationId: 'roomA',
        )
      ],
    ),
  ];
  final progress = TextGameProgress();
  final game = TextGameConfiguration(
    locations: locations,
  );
  final session = TextGameSession(
    game: game,
    progress: progress,
  );

  printCurrentLocation(session);

  session.performAction(session.currentActions.first);

  printCurrentLocation(session);
}

void printCurrentLocation(TextGameSession session) {
  final currentLocation = session.currentLocation;
  final actions = session.currentActions;
  print(currentLocation.description);
  print('');
  print('Exits:');
  for (var action in actions) {
    print('  - ${action.label}');
  }
}
