import 'package:text_adventure/src/configuration/variables/variable.dart';

class IntVariable extends Variable<int> {
  IntVariable({
    required super.id,
    super.initialValue = 0,
  });
}
