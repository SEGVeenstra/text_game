import 'package:text_adventure/src/description.dart';

class DescriptionConfiguration implements Description {
  DescriptionConfiguration({
    this.condition,
    required this.text,
  });

  final String? condition;
  @override
  final String text;
}
