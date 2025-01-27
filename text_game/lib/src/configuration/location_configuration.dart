import 'package:text_game/text_game.dart';

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
  final String description;

  @override
  final List<Action> actions;
}
