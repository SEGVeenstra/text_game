import 'package:text_adventure/src/configuration/effects/effect.dart';
import 'package:text_adventure/text_adventure.dart';

/// An effect that modifies the player's inventory.
///
/// If [add] is not `null`, the effect will add [add] items of [itemId] to the player's inventory.
/// If [set] is not `null`, the effect will set the number of items of [itemId] in the player's inventory to [set].
///
/// Either [add] or [set] must be provided, but not both.
class InventoryEffect extends Effect {
  InventoryEffect({
    required this.itemId,
    this.add,
    this.set,
  }) {
    assert(add != null || set != null);
    assert(add == null || set == null);
  }

  final String itemId;
  final int? add;
  final int? set;

  @override
  void apply(TextAdventureSession session) {
    if (add != null) {
      session.progress.addItem(itemId, add!);
    } else if (set != null) {
      session.progress.setItem(itemId, set!);
    }
  }
}
