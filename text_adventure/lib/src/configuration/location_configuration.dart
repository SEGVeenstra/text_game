import 'package:text_adventure/text_adventure.dart';

class LocationConfiguration implements Location {
  const LocationConfiguration({
    required this.id,
    required this.name,
    required this.description,
    required this.actions,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final List<DescriptionConfiguration> description;

  @override
  final List<ActionConfiguration> actions;

  LocationConfiguration copyWith({
    List<DescriptionConfiguration>? description,
  }) {
    return LocationConfiguration(
      id: id,
      name: name,
      description: description ?? this.description,
      actions: actions,
    );
  }
}
