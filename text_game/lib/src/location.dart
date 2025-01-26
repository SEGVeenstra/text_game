class Location {
  const Location({
    required this.id,
    required this.name,
    required this.description,
    required this.exits,
  });

  final String id;
  final String name;
  final String description;

  final List<String> exits;
}
