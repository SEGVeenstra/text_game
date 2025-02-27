import 'package:text_adventure/src/exceptions/text_adventure_exception.dart';

class NavigationException extends TextAdventureException {
  NavigationException({
    required String locationId,
  }) : super(message: 'Invalid location: $locationId');
}
