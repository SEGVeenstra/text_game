import 'package:text_game/text_game.dart';

final exampleGame = TextGameConfiguration(
  meta: MetaConfiguration(
    title: 'Example',
    version: Version(1, 0, 0),
  ),
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
      description: [
        DescriptionConfiguration(
          text: 'It\'s a bit dark in here.',
          condition: '!vars.hall_light',
        ),
        DescriptionConfiguration(
          text: 'The hallway is well lit.',
          condition: 'vars.hall_light',
        ),
      ],
      actions: [
        ActionConfiguration(
          type: ActionType.navigate,
          label: 'To the living room',
          condition: 'vars.hall_light',
          effect: 'location = living',
        ),
        ActionConfiguration(
          type: ActionType.use,
          label: 'Turn on the light',
          condition: '!vars.hall_light',
          effect: 'vars.hall_light = true',
        ),
        ActionConfiguration(
          type: ActionType.use,
          label: 'Turn off the light',
          condition: 'vars.hall_light',
          effect: 'vars.hall_light = false',
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
      description: [
        DescriptionConfiguration(text: 'The sofa looks very comfy!')
      ],
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
          message:
              "You hear a click from the kitchen door and the light on the lock turns green.",
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
      description: [
        DescriptionConfiguration(
            text: 'There is a very expensive looking fridge in here.'),
      ],
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
