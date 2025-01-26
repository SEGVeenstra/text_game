import 'package:text_game/text_game.dart';

class TextGameSession {
  TextGameSession({
    required this.game,
    required this.progress,
  });

  final TextGame game;
  final TextGameProgress progress;

  Location get currentLocation {
    if (progress.currentLocationId == null) {
      return game.locations.first;
    }
    return game.locations.firstWhere(
      (location) => location.id == progress.currentLocationId,
    );
  }

  List<Location> get currentExits {
    return currentLocation.exits
        .map((exitId) =>
            game.locations.firstWhere((location) => location.id == exitId))
        .toList();
  }

  void go(String exitId) {
    if (currentLocation.exits.contains(exitId)) {
      progress.updateLocation(exitId);
    }
  }
}
