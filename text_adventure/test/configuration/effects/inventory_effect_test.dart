import 'package:test/test.dart';
import 'package:text_adventure/src/configuration/effects/inventory_effect.dart';
import 'package:text_adventure/text_adventure.dart';

void main() {
  late TextAdventureSession session;

  setUp(() {
    final game = TextAdventureConfiguration(
      variables: [],
      items: [],
      locations: [],
      meta: MetaConfiguration(
        title: 'title',
        version: Version(1, 0, 1),
      ),
    );
    final progress = TextAdventureProgress();
    session = TextAdventureSession(game: game, progress: progress);
  });

  group('add ', () {
    test('with positive number adds item to inventory', () {
      final effect = InventoryEffect(itemId: 'item', add: 10);
      effect.apply(session);
      expect(session.progress.inventory['item'], 10);
    });

    // test('with negative number removes item from inventory', () {
    //   final progress = TextAdventureProgress(inventory: {'item': 1});
    //   final effect = InventoryEffect(itemId: 'item', add: -1);
    //   effect.apply(progress);
    //   expect(progress.inventory['item'], 0);
    // });
  });

  group('set', () {
    // test(
    //     'when item is not in inventory sets the number of items in the inventory',
    //     () {
    //   final progress = TextAdventureProgress();
    //   final effect = InventoryEffect(itemId: 'item', set: 10);
    //   effect.apply(progress);
    //   expect(progress.inventory['item'], 10);
    // });

    // test(
    //     'when item is already in inventory, overrides the number of items in the inventory',
    //     () {
    //   final progress = TextAdventureProgress(inventory: {'item': 5});
    //   final effect = InventoryEffect(itemId: 'item', set: 8);
    //   effect.apply(progress);
    //   expect(progress.inventory['item'], 8);
    // });
  });
}
