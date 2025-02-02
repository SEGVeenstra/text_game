import 'package:text_game/text_game.dart';

final exampleGame = TextGameConfiguration(
  items: [
    Item(
      id: 'key',
      name: 'Key',
      description: 'A key you found in the kitchen.\nWhat could it be for?',
    ),
    Item(
      id: 'gold',
      name: 'Gold',
      description: 'Shiny gold coin(s).',
    ),
  ],
  locations: [
    LocationConfiguration(
      id: 'hall',
      name: 'Hallway',
      description: 'It\'s a bit dark in here.',
      actions: [
        ActionConfiguration(
          type: ActionType.navigate,
          label: 'To the living room',
          effect: 'location = living',
        ),
        ActionConfiguration(
          type: ActionType.use,
          label: 'Add gold',
          effect: 'inventory.gold++',
        ),
        ActionConfiguration(
          type: ActionType.use,
          label: 'Remove gold',
          condition: 'inventory.gold > 0',
          effect: 'inventory.gold--',
        ),
      ],
    ),
    LocationConfiguration(
      id: 'living',
      name: 'Living Room',
      description: 'The sofa looks very comfy!',
      actions: [
        ActionConfiguration(
          type: ActionType.navigate,
          label: 'To the hallway',
          effect: 'location = hall',
        ),
        ActionConfiguration(
          label: 'Push mysterious button',
          condition: '!vars.pushed_button',
          effect: 'vars.pushed_button = true',
          type: ActionType.use,
        ),
        ActionConfiguration(
          type: ActionType.navigate,
          label: 'To the kitchen',
          condition: 'vars.pushed_button',
          effect: 'location = kitchen',
        ),
      ],
    ),
    LocationConfiguration(
      id: 'kitchen',
      name: 'Kitchen',
      description: 'There is a very expensive looking fridge in here.',
      actions: [
        ActionConfiguration(
          type: ActionType.navigate,
          label: 'To the living room',
          effect: 'location = living',
        ),
        ActionConfiguration(
          type: ActionType.use,
          label: 'Add key to inventory',
          condition: '!inventory.key',
          effect: 'inventory.key = 1',
        ),
        ActionConfiguration(
          type: ActionType.use,
          label: 'Remove key from inventory',
          condition: 'inventory.key',
          effect: 'inventory.key = null',
        ),
      ],
    ),
  ],
);
