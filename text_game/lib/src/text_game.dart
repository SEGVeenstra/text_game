import 'package:text_game/src/location.dart';

/// A class representing a text-based game.
///
/// This is purly the configuration of the game which never actually changes.
class TextGame {
  TextGame({
    required this.locations,
  });

  final List<Location> locations;
}
