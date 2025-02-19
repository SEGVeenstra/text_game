import 'package:text_game/text_game.dart';
import 'package:yaml/yaml.dart';

TextGameConfiguration textGameConfigurationFromYaml(YamlMap yaml) {
  final title = yaml['meta']['title'];
  final description = yaml['meta']['description'];
  final author = yaml['meta']['author'];

  final version = yaml['meta']['version'].split('.');
  final versionObj = Version(
    int.parse(version[0]),
    int.parse(version[1]),
    int.parse(version[2]),
  );

  final locationsList = yaml['locations'] as YamlList;
  final locations =
      locationsList.map((l) => _locationConfigurationFromYaml(l)).toList();

  final itemsList = yaml['items'] as YamlList;
  final items = itemsList.map((i) => _itemFromYaml(i)).toList();

  return TextGameConfiguration(
    meta: MetaConfiguration(
      title: title,
      description: description,
      version: versionObj,
      author: author,
    ),
    items: items,
    locations: locations,
  );
}

LocationConfiguration _locationConfigurationFromYaml(YamlMap yaml) {
  final id = yaml['id'];
  final name = yaml['name'];
  final descriptionList = yaml['description'] as YamlList;

  final description =
      descriptionList.map((d) => _descriptionConfigurationFromYaml(d)).toList();

  final actionsList = yaml['actions'] as YamlList;
  final actions =
      actionsList.map((a) => _actionConfigurationFromYaml(a)).toList();

  return LocationConfiguration(
    id: id,
    name: name,
    description: description,
    actions: actions,
  );
}

DescriptionConfiguration _descriptionConfigurationFromYaml(YamlMap yaml) {
  final text = yaml['text'];
  final condition = yaml['condition'];

  return DescriptionConfiguration(
    text: text,
    condition: condition,
  );
}

ActionConfiguration _actionConfigurationFromYaml(YamlMap yaml) {
  final label = yaml['label'];
  final message = yaml['message'];
  final condition = yaml['condition'];
  final effect = yaml['effect'];

  final type = switch (yaml['type']) {
    'navigate' => ActionType.navigate,
    _ => ActionType.use,
  };

  return ActionConfiguration(
    label: label,
    message: message,
    type: type,
    condition: condition,
    effect: effect,
  );
}

Item _itemFromYaml(YamlMap yaml) {
  final id = yaml['id'];
  final name = yaml['name'];
  final description = yaml['description'];

  return Item(
    id: id,
    name: name,
    description: description,
  );
}
