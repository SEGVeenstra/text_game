import 'package:text_game/src/configuration/action_configuration.dart';

class LocationConfiguration {
  const LocationConfiguration({
    required this.id,
    required this.name,
    required this.description,
    required this.actions,
  });

  final String id;
  final String name;
  final String description;

  final List<ActionConfiguration> actions;
}
