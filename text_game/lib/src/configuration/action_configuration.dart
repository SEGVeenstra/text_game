import 'package:text_game/text_game.dart';

class ActionConfiguration implements Action {
  const ActionConfiguration({
    required this.label,
    required this.effect,
    required this.type,
    this.condition,
    this.message,
  });

  @override
  final String label;

  @override
  final ActionType type;

  final String effect;

  final String? condition;

  @override
  final String? message;
}
