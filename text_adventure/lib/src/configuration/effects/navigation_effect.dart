import 'package:text_adventure/src/configuration/effects/effect.dart';
import 'package:text_adventure/src/text_adventure_progress.dart';

class NavigationEffect extends Effect {
  NavigationEffect(this.location);

  final String location;

  @override
  void apply(TextAdventureProgress progress) {
    progress.updateLocation(location);
  }
}
