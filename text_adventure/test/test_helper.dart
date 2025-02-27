import 'package:text_adventure/src/configuration/effects/navigation_effect.dart';
import 'package:text_adventure/src/configuration/variables/bool_variable.dart';
import 'package:text_adventure/src/configuration/variables/int_variable.dart';
import 'package:text_adventure/text_adventure.dart';

TextAdventureSession createTestSession() {
  final game = TextAdventureConfiguration(
    meta: MetaConfiguration(
      title: 'title',
      version: Version(1, 2, 3),
    ),
    items: [
      Item(
        id: 'gold',
        name: 'Gold',
        description: 'Gold coins',
      ),
      Item(
        id: 'key',
        name: 'Key',
        description: 'A key',
      ),
    ],
    variables: [
      BoolVariable(
        id: 'lightOn',
        initialValue: false,
      ),
      IntVariable(
        id: 'experience',
        initialValue: 0,
      ),
      IntVariable(
        id: 'health',
        initialValue: 100,
      ),
    ],
    locations: [
      LocationConfiguration(
        id: 'room1',
        name: 'Room 1',
        description: [
          DescriptionConfiguration(text: 'You are in room 1'),
        ],
        actions: [
          ActionConfiguration(
            label: 'Go to room 2',
            effects: [
              NavigationEffect(location: 'room2'),
            ],
            type: ActionType.navigate,
            message: 'You go to room 2',
          ),
        ],
      ),
      LocationConfiguration(
        id: 'room2',
        name: 'Room 2',
        description: [
          DescriptionConfiguration(text: 'You are in room 2'),
        ],
        actions: [
          ActionConfiguration(
            label: 'Go to room 1',
            effects: [
              NavigationEffect(location: 'room1'),
            ],
            type: ActionType.navigate,
          ),
        ],
      ),
    ],
  );

  final progress = TextAdventureProgress(
    currentLocationId: 'room1',
    variables: {
      'lightOn': false,
      'experience': 0,
      'health': 100,
    },
    inventory: {
      'gold': 500,
    },
  );

  return TextAdventureSession(
    game: game,
    progress: progress,
  );
}
