import 'package:test/test.dart';
import 'package:text_game/src/parsers/condition_parser.dart';

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
            'inventory.key': true,
            'inventory.gold': true,
            'inventory.sword': false,
            'vars.light_on': true,
            'vars.light_on && inventory.gold > 10': true,
            'vars.boss_hp > 20': true,
            'vars.boss_hp < 20': false,
            'vars.boss_hp == 30': true,
            'vars.boss_hp != 30': false,
            '!vars.light_on': false,
            '!(vars.boss_hp > 20)': false,
            '!inventory.key': false,
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
