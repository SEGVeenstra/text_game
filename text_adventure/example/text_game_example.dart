import 'package:text_adventure/src/configuration/effects/navigation_effect.dart';
import 'package:text_adventure/text_adventure.dart';

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
          effects: [
            NavigationEffect(location: 'roomB'),
          ],
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
          effects: [
            NavigationEffect(location: 'roomA'),
          ],
        ),
      ],
    ),
  ];
  final progress = TextAdventureProgress();
  final game = TextAdventureConfiguration(
    meta: MetaConfiguration(
      title: 'Test',
      version: Version(1, 0, 0),
    ),
    locations: locations,
    variables: [],
    items: [
      Item(id: 'key', name: 'Key', description: 'A key'),
    ],
  );
  final session = TextAdventureSession(
    game: game,
    progress: progress,
  );

  printCurrentLocation(session);

  session.performAction(session.currentActions.first);

  printCurrentLocation(session);
}

void printCurrentLocation(TextAdventureSession session) {
  final currentLocation = session.currentLocation;
  final actions = session.currentActions;
  print(currentLocation.description);
  print('');
  print('Actions:');
  for (var action in actions) {
    print('  - ${action.label}');
  }
}
