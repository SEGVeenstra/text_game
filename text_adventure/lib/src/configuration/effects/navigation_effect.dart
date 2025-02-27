import 'package:text_adventure/src/configuration/effects/effect.dart';
import 'package:text_adventure/src/exceptions/navigation_exception.dart';
import 'package:text_adventure/text_adventure.dart';

class NavigationEffect extends Effect {
  NavigationEffect({required this.location});

  final String location;

  @override
  void apply(TextAdventureSession session) {
    final isValidLocation =
        session.game.locations.map((e) => e.id).contains(location);

    if (!isValidLocation) throw NavigationException(locationId: location);

    session.progress.updateLocation(location);
  }
}
