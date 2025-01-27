import 'package:text_game/src/configuration/action_configuration.dart';
import 'package:text_game/src/effect.dart';

abstract class Action {
  const Action({
    required this.label,
    required this.effects,
  });

  final String label;

  final List<Effect> effects;

  factory Action.fromConfiguration(ActionConfiguration configuration) =>
      switch (configuration) {
        NavigationActionConfiguration() =>
          NavigationAction.fromConfiguration(configuration),
      };
}

class NavigationAction extends Action {
  const NavigationAction({
    required super.label,
    required super.effects,
    required this.locationId,
  });

  final String locationId;

  NavigationAction.fromConfiguration(
      NavigationActionConfiguration configuration)
      : this(
          label: configuration.label,
          effects: configuration.effects,
          locationId: configuration.locationId,
        );
}
