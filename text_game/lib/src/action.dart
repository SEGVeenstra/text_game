import 'package:text_game/src/effect.dart';

abstract class Action {
  String get label;

  List<Effect> get effects;
}
