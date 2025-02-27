import 'package:test/test.dart';
import 'package:text_adventure/src/configuration/effects/navigation_effect.dart';
import 'package:text_adventure/src/exceptions/navigation_exception.dart';
import 'package:text_adventure/text_adventure.dart';

void main() async {
  late TextAdventureSession session;

  setUp(
    () {
      session = TextAdventureSession(
        game: TextAdventureConfiguration(
          locations: [
            LocationConfiguration(
              id: 'room1',
              name: 'name',
              description: [],
              actions: [
                ActionConfiguration(
                  label: 'go',
                  effects: [
                    NavigationEffect(location: 'room2'),
                  ],
                  type: ActionType.navigate,
                ),
              ],
            ),
            LocationConfiguration(
              id: 'room2',
              name: 'name',
              description: [],
              actions: [],
            ),
          ],
          items: [],
          variables: [],
          meta: MetaConfiguration(
            title: 'title',
            version: Version(1, 0, 1),
          ),
        ),
        progress: TextAdventureProgress(
          currentLocationId: 'room1',
        ),
      );
    },
  );

  test(
    'navigate to non-existing location throws exception',
    () {
      final action = ActionConfiguration(
        label: 'go',
        effects: [
          NavigationEffect(location: 'non-existing-location'),
        ],
        type: ActionType.navigate,
      );

      expect(
        () => session.performAction(action),
        throwsA(
          isA<NavigationException>(),
        ),
      );
    },
  );

  test(
    'navigate to existing location updates the current location',
    () {
      final action = ActionConfiguration(
        label: 'go',
        effects: [
          NavigationEffect(location: 'room2'),
        ],
        type: ActionType.navigate,
      );

      session.performAction(action);

      expect(
        session.currentLocation.id,
        'room2',
      );
    },
  );
}
