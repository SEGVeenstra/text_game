import 'package:text_game/text_game.dart';

final exampleGame = TextGameConfiguration(
  locations: [
    LocationConfiguration(
      id: 'hall',
      name: 'Hallway',
      description: 'It\'s a bit dark in here.',
      actions: [
        NavigationAction(
          label: 'To the living room',
          effects: [],
          locationId: 'living',
        ),
      ],
    ),
    LocationConfiguration(
      id: 'living',
      name: 'Living Room',
      description: 'The sofa looks very comfy!',
      actions: [
        NavigationAction(
          label: 'To the hallway',
          effects: [],
          locationId: 'hall',
        ),
        NavigationAction(
          label: 'To the kitchen',
          effects: [],
          locationId: 'kitchen',
        ),
      ],
    ),
    LocationConfiguration(
      id: 'kitchen',
      name: 'Kitchen',
      description: 'There is a very expensive looking fridge in here.',
      actions: [
        NavigationAction(
          label: 'To the living room',
          effects: [],
          locationId: 'living',
        ),
      ],
    ),
  ],
);
