import 'package:test/test.dart';
import 'package:text_game/text_game.dart';

void main() {
  test(
    'textGameConfigurationFromYaml',
    () {
      final yaml = '''
meta:
  title: Test Game
  description: A test game
  author: Test Author
  version: 1.2.3
items:
  - id: testItem
    name: Test Item
    description: Test Item Description
locations:
  - id: test
    name: Test Location
    description:
      - text: Static description
      - text: Conditional description
        condition: vars.testVar == 1
    actions:
      - type: navigate
        label: Test Action Label
        effect: vars.testVar = 1
  - id: test2
    name: Test Location 2
    description:
      - text: Static description
      - text: Conditional description
        condition: vars.testVar == 1
''';

      final config = textGameConfigurationFromYaml(loadYaml(yaml));

      expect(config.meta.title, 'Test Game');
      expect(config.meta.description, 'A test game');
      expect(config.meta.author, 'Test Author');
      expect(config.meta.version, Version(1, 2, 3));
      expect(config.locations.length, 2);

      final item = config.items[0];
      expect(item.id, 'testItem');
      expect(item.name, 'Test Item');
      expect(item.description, 'Test Item Description');

      final location = config.locations[0];
      expect(location.id, 'test');
      expect(location.name, 'Test Location');
      expect(location.description.length, 2);
      expect(location.description[0].text, 'Static description');
      expect(location.description[0].condition, null);
      expect(location.description[1].text, 'Conditional description');
      expect(location.description[1].condition, 'vars.testVar == 1');
      expect(location.actions.length, 1);
      expect(location.actions[0].label, 'Test Action Label');
      expect(location.actions[0].effect, 'vars.testVar = 1');
      expect(location.actions[0].type, ActionType.navigate);
    },
  );
}
