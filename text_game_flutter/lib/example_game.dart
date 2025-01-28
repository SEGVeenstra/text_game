import 'package:text_game/text_game.dart';

final exampleGame = TextGameConfiguration(
  items: [
    Item(id: 'key', name: 'Key'),
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
          effects: [
            NavigationEffect(locationId: 'living'),
          ],
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
          effects: [
            NavigationEffect(locationId: 'hall'),
          ],
        ),
        ActionConfiguration(
          type: ActionType.navigate,
          label: 'To the kitchen',
          effects: [
            NavigationEffect(locationId: 'kitchen'),
          ],
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
          effects: [
            NavigationEffect(locationId: 'living'),
          ],
        ),
        ActionConfiguration(
          type: ActionType.use,
          label: 'Add key to inventory',
          effects: [
            AddItemEffect(itemId: 'key'),
          ],
        ),
        ActionConfiguration(
          type: ActionType.use,
          label: 'Remove key from inventory',
          effects: [
            RemoveItemEffect(itemId: 'key'),
          ],
        ),
      ],
    ),
  ],
);
