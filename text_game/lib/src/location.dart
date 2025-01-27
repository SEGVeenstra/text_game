import 'package:text_game/src/action.dart';

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
}
