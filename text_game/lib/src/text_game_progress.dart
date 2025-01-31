import 'package:text_game/text_game.dart';

class TextGameProgress {
  TextGameProgress({
    String? currentLocationId,
    Map<String, int>? inventory,
    Map<String, dynamic>? variables,
  })  : _currentLocationId = currentLocationId,
        inventory = inventory ?? {},
        variables = variables ?? {};

  String? _currentLocationId;

  final Map<String, int> inventory;
  final Map<String, dynamic> variables;

  String? get currentLocationId => _currentLocationId;

  void updateLocation(String locationId) {
    _currentLocationId = locationId;
  }

  void addItem(Item item) {
    inventory.update(item.id, (value) => value + 1, ifAbsent: () => 1);
  }

  void removeItem(Item item) {
    if (inventory.containsKey(item.id)) {
      inventory.update(item.id, (value) => value - 1);
      if (inventory[item.id] == 0) {
        inventory.remove(item.id);
      }
    }
  }

  void setVariable(String id, dynamic value) {
    variables[id] = value;
  }

  dynamic getVariable(String id) {
    return variables[id];
  }

  void clearVariable(String id) {
    variables.remove(id);
  }
}
