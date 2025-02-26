import 'package:text_adventure/src/configuration/variables/variable.dart';

class BoolVariable extends Variable<bool> {
  BoolVariable({
    required super.id,
    super.initialValue = false,
  });
}
