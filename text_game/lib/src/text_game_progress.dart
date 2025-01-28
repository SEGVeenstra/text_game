import 'package:text_game/text_game.dart';

class TextGameProgress {
  TextGameProgress({
    String? currentLocationId,
    Map<Item, int>? inventory,
  })  : _currentLocationId = currentLocationId,
        inventory = inventory ?? {};

  String? _currentLocationId;

  final Map<Item, int> inventory;

  String? get currentLocationId => _currentLocationId;

  void updateLocation(String locationId) {
    _currentLocationId = locationId;
  }

  void addItem(Item item) {
    inventory.update(item, (value) => value + 1, ifAbsent: () => 1);
  }

  void removeItem(Item item) {
    if (inventory.containsKey(item)) {
      inventory.update(item, (value) => value - 1);
      if (inventory[item] == 0) {
        inventory.remove(item);
      }
    }
  }
}
