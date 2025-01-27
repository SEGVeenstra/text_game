abstract class Effect {
  const Effect();
}

class NavigationEffect extends Effect {
  const NavigationEffect({
    required this.destination,
  });

  final String destination;
}
