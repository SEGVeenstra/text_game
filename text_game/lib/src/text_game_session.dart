import 'dart:async';

import 'package:collection/collection.dart';
import 'package:text_game/src/parsers/condition_parser.dart';
import 'package:text_game/src/parsers/effect_parser.dart';
import 'package:text_game/text_game.dart';

class TextGameSessionEvent {
  const TextGameSessionEvent({
    required this.message,
  });
  final String message;
}

class TextGameSession {
  TextGameSession({
    required this.game,
    required this.progress,
  });

  final TextGameConfiguration game;
  final TextGameProgress progress;
  final _eventsController = StreamController<TextGameSessionEvent>.broadcast();
  Stream get events => _eventsController.stream;

  Location get currentLocation {
    final LocationConfiguration locationConfig;
    if (progress.currentLocationId == null) {
      locationConfig = game.locations.first;
    } else {
      locationConfig = game.locations.firstWhere(
        (location) => location.id == progress.currentLocationId,
      );
    }
    final description = locationConfig.description.where(
      (d) =>
          d.condition == null ||
          ConditionParser(
            variables: progress.variables,
            inventory: progress.inventory,
          ).evaluate(d.condition!),
    );
    return locationConfig.copyWith(description: description.toList());
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
    if (action.message != null) {
      _eventsController.add(
        TextGameSessionEvent(
          message: action.message!,
        ),
      );
    }
  }
}
