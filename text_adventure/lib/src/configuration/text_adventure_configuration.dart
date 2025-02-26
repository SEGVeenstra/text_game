import 'package:text_adventure/src/configuration/location_configuration.dart';
import 'package:text_adventure/src/configuration/meta_configuration.dart';
import 'package:text_adventure/src/configuration/variables/variable.dart';
import 'package:text_adventure/src/item.dart';

/// A class representing a text-based game.
///
/// This is purly the configuration of the game which never actually changes.
class TextAdventureConfiguration {
  TextAdventureConfiguration({
    required this.locations,
    required this.items,
    required this.variables,
    required this.meta,
  });

  final List<LocationConfiguration> locations;
  final List<Item> items;
  final List<Variable> variables;
  final MetaConfiguration meta;
}
