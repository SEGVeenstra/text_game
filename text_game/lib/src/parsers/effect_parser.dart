class EffectParser {
  final Map<String, int> inventory;
  final Map<String, dynamic> variables;
  final void Function(String newLocation) onLocationChange;

  EffectParser(this.inventory, this.variables, this.onLocationChange);

  void parseAndExecute(String effect) {
    // Split the effect string into individual actions
    final actions = effect.split('&&').map((action) => action.trim());

    for (var action in actions) {
      _executeAction(action);
    }
  }

  void _executeAction(String action) {
    if (action.contains('=')) {
      // Assignment or clearing syntax
      final parts = action.split('=').map((part) => part.trim()).toList();
      if (parts.length != 2)
        throw Exception('Invalid assignment syntax: $action');

      final target = parts[0];
      final value = parts[1];

      if (target.startsWith('inventory.')) {
        final itemId = target.substring(10);
        if (value == 'null') {
          _clearItem(itemId);
        } else {
          _setItem(itemId, int.parse(value));
        }
      } else if (target == 'location') {
        _goTo(value);
      } else if (target.startsWith('vars.')) {
        final varName = target.substring(5);
        _setVar(varName, _parseValue(value));
      } else {
        throw Exception('Unknown target: $target');
      }
    } else if (action.contains('+') || action.contains('-')) {
      // Addition or subtraction syntax
      final operatorMatch =
          RegExp(r'([\w\.]+)\s*([\+\-]{1,2})\s*(\d+)?').firstMatch(action);
      if (operatorMatch == null)
        throw Exception('Invalid shorthand syntax: $action');

      final target = operatorMatch.group(1)!; // e.g., "inventory.key"
      final operator = operatorMatch.group(2)!; // e.g., "++" or "-"
      final value =
          operatorMatch.group(3); // e.g., "100" or null for shorthand like "--"

      if (target.startsWith('inventory.')) {
        final itemId = target.substring(10);
        final amount = (value != null ? int.parse(value) : 1) *
            (operator.contains('-') ? -1 : 1);
        _addItem(itemId, amount);
      } else if (target.startsWith('vars.')) {
        final varName = target.substring(5);
        final amount = (value != null ? num.parse(value) : 1) *
            (operator.contains('-') ? -1 : 1);
        _addVar(varName, amount);
      } else {
        throw Exception('Unknown target: $target');
      }
    } else {
      throw Exception('Invalid effect syntax: $action');
    }
  }

  void _addItem(String itemId, int amount) {
    inventory[itemId] = (inventory[itemId] ?? 0) + amount;
    if (inventory[itemId]! <= 0) inventory.remove(itemId);
  }

  void _setItem(String itemId, int amount) {
    inventory[itemId] = amount;
  }

  void _clearItem(String itemId) {
    inventory.remove(itemId);
  }

  void _setVar(String varName, dynamic value) {
    variables[varName] = value;
  }

  void _addVar(String varName, num value) {
    if (variables[varName] is! num) {
      throw Exception('Variable $varName is not numeric.');
    }
    variables[varName] = (variables[varName] ?? 0) + value;
  }

  void _goTo(String locationId) {
    onLocationChange(locationId);
  }

  dynamic _parseValue(String value) {
    if (value == 'true') return true;
    if (value == 'false') return false;
    if (value == 'null') return null;
    if (RegExp(r'^-?\d+$').hasMatch(value)) return int.parse(value);
    if (RegExp(r'^-?\d+\.\d+$').hasMatch(value)) return double.parse(value);
    return value; // Assume string
  }
}
