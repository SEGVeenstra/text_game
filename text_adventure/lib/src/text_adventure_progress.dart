class TextAdventureProgress {
  TextAdventureProgress({
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

  void addItem(String itemId, [int amount = 1]) {
    inventory.update(itemId, (value) => value + amount, ifAbsent: () => amount);
  }

  void setItem(String itemId, int amount) {
    inventory.update(itemId, (value) => amount, ifAbsent: () => amount);
  }

  void setVariable(String id, dynamic value) {
    final currentValue = variables[id];
    if (currentValue.runtimeType == value.runtimeType) {
      throw '$value is not of type ${currentValue.runtimeType}';
    }
    variables[id] = value;
  }

  void incrementVariable(String id, dynamic value) {
    final currentValue = variables[id];
    if (currentValue is! num) {
      throw '$value is not of type ${currentValue.runtimeType}';
    }
    variables[id] += value;
  }

  dynamic getVariable(String id) {
    return variables[id];
  }

  void clearVariable(String id) {
    variables.remove(id);
  }
}
