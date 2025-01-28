import 'package:text_game/src/effect.dart';

enum ActionType {
  navigate,
  use,
}

abstract class Action {
  String get label;
  ActionType get type;
  List<Effect> get effects;
}
