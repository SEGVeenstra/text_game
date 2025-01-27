import 'package:text_game/text_game.dart';

class Location {
  Location(
    this.id,
    this.name,
    this.description,
    this.actions,
  );

  final String id;
  final String name;
  final String description;

  List<Action> actions;

  factory Location.fromConfiguration(LocationConfiguration configuration) {
    return Location(
      configuration.id,
      configuration.name,
      configuration.description,
      configuration.actions
          .map((action) => Action.fromConfiguration(action))
          .toList(),
    );
  }
}
