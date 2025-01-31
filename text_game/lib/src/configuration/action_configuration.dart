import 'package:text_game/text_game.dart';

class ActionConfiguration implements Action {
  const ActionConfiguration({
    required this.label,
    required this.effects,
    required this.type,
    this.condition,
  });

  @override
  final String label;

  @override
  final ActionType type;

  final List<Effect> effects;

  final String? condition;
}
