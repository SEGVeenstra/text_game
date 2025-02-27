import 'dart:async';

import 'package:collection/collection.dart';
import 'package:text_adventure/src/parsers/condition_parser.dart';
import 'package:text_adventure/text_adventure.dart';

class TextAdventureSessionEvent {
  const TextAdventureSessionEvent({
    required this.message,
  });
  final String message;
}

class TextAdventureSession {
  TextAdventureSession({
    required this.game,
    required this.progress,
  });

  final TextAdventureConfiguration game;
  TextAdventureProgress progress;
  final _eventsController =
      StreamController<TextAdventureSessionEvent>.broadcast();
  Stream<TextAdventureSessionEvent> get events => _eventsController.stream;

  void loadProgress(TextAdventureProgress progress) {
    this.progress = progress;
  }

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

    for (var effect in action.effects) {
      effect.apply(this);
    }

    if (action.message != null) {
      _eventsController.add(
        TextAdventureSessionEvent(
          message: action.message!,
        ),
      );
    }
  }
}
