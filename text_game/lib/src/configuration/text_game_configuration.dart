import 'package:text_game/src/configuration/location_configuration.dart';
import 'package:text_game/src/item.dart';

/// A class representing a text-based game.
///
/// This is purly the configuration of the game which never actually changes.
class TextGameConfiguration {
  TextGameConfiguration({
    required this.locations,
    required this.items,
  });

  final List<LocationConfiguration> locations;
  final List<Item> items;
}
