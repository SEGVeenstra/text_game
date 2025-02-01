import 'package:collection/collection.dart';
import 'package:text_game/src/parsers/condition_parser.dart';
import 'package:text_game/src/parsers/effect_parser.dart';
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
        .where((action) => action.condition != null
            ? ConditionParser(
                    variables: progress.variables,
                    inventory: progress.inventory)
                .evaluate(action.condition!)
            : true)
        .toList();
  }

  Map<Item, int> get inventory {
    return progress.inventory.map((itemId, count) {
      final item = game.items.firstWhere((item) => item.id == itemId);
      return MapEntry(item, count);
    });
  }

  void performAction(Action action) {
    action as ActionConfiguration;

    EffectParser(
      progress.inventory,
      progress.variables,
      progress.updateLocation,
    ).parseAndExecute(action.effect);
  }
}
