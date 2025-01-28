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
          label: 'To the hallway',
          effects: [
            NavigationEffect(locationId: 'hall'),
          ],
        ),
        ActionConfiguration(
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
          label: 'To the living room',
          effects: [
            NavigationEffect(locationId: 'living'),
          ],
        ),
        ActionConfiguration(
          label: 'Add key to inventory',
          effects: [
            AddItemEffect(itemId: 'key'),
          ],
        ),
        ActionConfiguration(
          label: 'Remove key from inventory',
          effects: [
            RemoveItemEffect(itemId: 'key'),
          ],
        ),
      ],
    ),
  ],
);
