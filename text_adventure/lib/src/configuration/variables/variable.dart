class Variable<T> {
  Variable({
    required this.id,
    required this.initialValue,
  });

  final String id;
  final T initialValue;
}
