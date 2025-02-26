import 'package:test/test.dart';
import 'package:text_adventure/src/configuration/effects/variable_effect.dart';
import 'package:text_adventure/src/configuration/variables/variable.dart';
import 'package:text_adventure/text_adventure.dart';

void main() {
  group('add ', () {
    test('with positive number adds value to variable', () {
      final progress = TextAdventureProgress(variables: {'gold': 0});
      final effect = VariableEffect(variableName: 'gold', add: 100);
      effect.apply(progress, [
        Variable(
          id: 'gold',
          initialValue: 0,
        ),
      ]);
      expect(progress.getVariable('gold'), 100);
    });

    test('with negative number removes value from variable', () {
      final progress = TextAdventureProgress(variables: {'gold': 100});
      final effect = VariableEffect(variableName: 'gold', add: -50);
      effect.apply(progress, [
        Variable(
          id: 'gold',
          initialValue: 0,
        ),
      ]);
      expect(progress.getVariable('gold'), 50);
    });
  });
}
