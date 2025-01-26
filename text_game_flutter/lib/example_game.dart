import 'package:text_game/text_game.dart';

final exampleGame = TextGame(
  locations: [
    Location(
      id: 'hall',
      name: 'Hallway',
      description: 'It\'s a bit dark in here.',
      exits: ['living'],
    ),
    Location(
      id: 'living',
      name: 'Living Room',
      description: 'The sofa looks very comfy!',
      exits: ['hall', 'kitchen'],
    ),
    Location(
      id: 'kitchen',
      name: 'Kitchen',
      description: 'There is a very expensive looking fridge in here.',
      exits: ['living'],
    ),
  ],
);
