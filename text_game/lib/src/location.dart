import 'package:text_game/src/description.dart';
import 'package:text_game/text_game.dart';

abstract class Location {
  String get id;
  String get name;
  List<Description> get description;

  List<Action> get actions;
}
