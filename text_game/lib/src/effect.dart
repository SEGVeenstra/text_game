abstract class Effect {
  const Effect();
}

class NavigationEffect extends Effect {
  const NavigationEffect({
    required this.locationId,
  });

  final String locationId;
}

class AddItemEffect extends Effect {
  const AddItemEffect({
    required this.itemId,
  });

  final String itemId;
}

class RemoveItemEffect extends Effect {
  const RemoveItemEffect({
    required this.itemId,
  });

  final String itemId;
}
