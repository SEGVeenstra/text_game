import 'package:pub_semver/pub_semver.dart';

class MetaConfiguration {
  const MetaConfiguration({
    required this.title,
    this.author = '',
    this.description = '',
    required this.version,
  });

  final String title;
  final String author;
  final String description;
  final Version version;
}
