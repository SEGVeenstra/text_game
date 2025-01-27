import 'package:text_game/text_game.dart';

abstract class Location {
  String get id;
  String get name;
  String get description;

  List<Action> get actions;
}
