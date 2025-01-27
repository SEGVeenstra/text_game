import 'package:text_game/src/effect.dart';

abstract class Action {
  const Action({
    required this.label,
    required this.effects,
  });

  final String label;

  final List<Effect> effects;
}

class NavigationAction extends Action {
  const NavigationAction({
    required super.label,
    required super.effects,
    required this.locationId,
  });

  final String locationId;
}
