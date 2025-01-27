import 'package:text_game/text_game.dart';

sealed class ActionConfiguration {
  const ActionConfiguration({
    required this.label,
    required this.effects,
  });

  final String label;

  final List<Effect> effects;
}

class NavigationActionConfiguration extends ActionConfiguration {
  const NavigationActionConfiguration({
    required super.label,
    required super.effects,
    required this.locationId,
  });

  final String locationId;
}
