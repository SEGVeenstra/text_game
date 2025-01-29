import 'package:collection/collection.dart';
import 'package:text_game/text_game.dart';

class TextGameSession {
  TextGameSession({
    required this.game,
    required this.progress,
  });

  final TextGameConfiguration game;
  final TextGameProgress progress;

  Location get currentLocation {
    if (progress.currentLocationId == null) {
      final locationConfig = game.locations.first;
      return locationConfig;
    }
    final locationConfig = game.locations.firstWhere(
      (location) => location.id == progress.currentLocationId,
    );
    return locationConfig;
  }

  /// Returns the list of actions the user can perform based on the current location.
  List<Action> get currentActions {
    final locationConfig = game.locations.firstWhereOrNull(
          (location) => location.id == progress.currentLocationId,
        ) ??
        game.locations.first;

    return locationConfig.actions
        .where((action) => action.condition?.evaluate(this) ?? true)
        .toList();
  }

  Map<Item, int> get inventory {
    return progress.inventory;
  }

  void performAction(Action action) {
    for (final effect in action.effects) {
      switch (effect) {
        case NavigationEffect(:final locationId):
          progress.updateLocation(locationId);
        case AddItemEffect(:final itemId):
          final item = game.items.firstWhere((item) => item.id == itemId);
          progress.addItem(item);
        case RemoveItemEffect(:final itemId):
          final item = game.items.firstWhere((item) => item.id == itemId);
          progress.removeItem(item);
        default:
          throw UnimplementedError('Effect not implemented: $effect');
      }
    }
  }
}
