import 'package:text_game/text_game.dart';

class ActionConfiguration implements Action {
  const ActionConfiguration({
    required this.label,
    required this.effects,
  });

  @override
  final String label;

  @override
  final List<Effect> effects;
}
