import 'package:text_adventure/src/configuration/effects/effect.dart';
import 'package:text_adventure/text_adventure.dart';

class ActionConfiguration implements Action {
  const ActionConfiguration({
    required this.label,
    required this.effects,
    required this.type,
    this.condition,
    this.message,
  });

  @override
  final String label;

  @override
  final ActionType type;

  final List<Effect> effects;

  final String? condition;

  @override
  final String? message;
}
