import 'package:test/test.dart';
import 'package:text_adventure/src/parsers/condition_parser.dart';

void main() {
  group(
    'ConditionParser',
    () {
      test(
        'evaluate',
        () {
          final inventory = <String, int>{
            'key': 1,
            'gold': 188,
          };
          final variables = <String, dynamic>{
            'light_on': true,
            'boss_hp': 30,
          };

          final parser = ConditionParser(
            inventory: inventory,
            variables: variables,
          );

          final tests = <String, bool>{
            'inventory.key > 0': true,
            'inventory.gold > 0': true,
            'inventory.sword > 0': false,
            'vars.light_on == true': true,
            'vars.light_on == true && inventory.gold > 10': true,
            'vars.light_on == true || inventory.gold > 1000': true,
            'inventory.key == false || inventory.gold < 1000': true,
            'inventory.key == false || inventory.gold > 1000': false,
            'vars.boss_hp > 20': true,
            'vars.boss_hp < 20': false,
            'vars.boss_hp == 30': true,
            '(vars.boss_hp != 30 && vars.light_on == true) || inventory.sword > 0':
                false,
          };

          tests.forEach(
            (expression, expected) {
              final result = parser.evaluate(expression);
              expect(result, expected, reason: expression);
            },
          );
        },
      );
    },
  );
}
