import 'package:text_adventure/text_adventure.dart';

abstract class Location {
  String get id;
  String get name;
  List<Description> get description;

  List<Action> get actions;
}
