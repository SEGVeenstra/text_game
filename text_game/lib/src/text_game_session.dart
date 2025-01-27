import 'package:collection/collection.dart';
import 'package:text_game/src/action.dart';
import 'package:text_game/src/location.dart';
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
      return Location(
        locationConfig.id,
        locationConfig.name,
        locationConfig.description,
        locationConfig.actions,
      );
    }
    final locationConfig = game.locations.firstWhere(
      (location) => location.id == progress.currentLocationId,
    );
    return Location(
      locationConfig.id,
      locationConfig.name,
      locationConfig.description,
      locationConfig.actions,
    );
  }

  /// Returns the list of actions the user can perform based on the current location.
  List<Action> get currentActions {
    final locationConfig = game.locations.firstWhereOrNull(
          (location) => location.id == progress.currentLocationId,
        ) ??
        game.locations.first;

    return locationConfig.actions;
  }

  void performAction(Action action) {
    switch (action) {
      case NavigationAction():
        progress.updateLocation(action.locationId);
        break;
    }
  }
}
