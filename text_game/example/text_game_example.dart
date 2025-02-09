import 'package:text_game/src/configuration/description_configuration.dart';
import 'package:text_game/text_game.dart';

void main() {
  final locations = [
    LocationConfiguration(
      id: 'roomA',
      name: 'Room A',
      description: [
        DescriptionConfiguration(text: 'You are in room A.'),
      ],
      actions: [
        ActionConfiguration(
          label: 'To room B',
          effect: 'goTo(roomB)',
          type: ActionType.navigate,
        ),
      ],
    ),
    LocationConfiguration(
      id: 'roomB',
      name: 'Room B',
      description: [
        DescriptionConfiguration(text: 'You are in room B.'),
      ],
      actions: [
        ActionConfiguration(
          type: ActionType.navigate,
          label: 'To room A',
          effect: 'goTo(roomA)',
        ),
      ],
    ),
  ];
  final progress = TextGameProgress();
  final game = TextGameConfiguration(
    locations: locations,
    items: [
      Item(id: 'key', name: 'Key', description: 'A key'),
    ],
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
  print('Actions:');
  for (var action in actions) {
    print('  - ${action.label}');
  }
}
