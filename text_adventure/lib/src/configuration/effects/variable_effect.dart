import 'package:collection/collection.dart';
import 'package:text_adventure/src/configuration/effects/effect.dart';
import 'package:text_adventure/src/configuration/variables/variable.dart';
import 'package:text_adventure/text_adventure.dart';

class VariableEffect<T> extends Effect {
  VariableEffect({required this.variableName, this.set, this.add}) {
    assert(set != null || add != null);
    assert(set == null || add == null);
  }

  final String variableName;
  final T? set;
  final T? add;

  @override
  void apply(TextAdventureProgress progress,
      [List<Variable>? variables = const []]) {
    final variableConfig =
        variables?.firstWhereOrNull((e) => e.id == variableName);

    if (variableConfig == null) {
      throw ArgumentError('Variable $variableName not found');
    }

    if (set != null) {
      progress.setVariable(variableName, set);
    } else if (add != null) {
      progress.incrementVariable(variableName, add);
    }
  }
}
