import 'package:collection/collection.dart';
import 'package:text_adventure/src/configuration/effects/effect.dart';
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
  void apply(TextAdventureSession session) {
    final variableConfig =
        session.game.variables.firstWhereOrNull((e) => e.id == variableName);

    if (variableConfig == null) {
      throw ArgumentError('Variable $variableName not found');
    }

    if (set != null) {
      session.progress.setVariable(variableName, set);
    } else if (add != null) {
      session.progress.incrementVariable(variableName, add);
    }
  }
}
