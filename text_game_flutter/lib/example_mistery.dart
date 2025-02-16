import 'package:text_game/text_game.dart';

final misteryExample = TextGameConfiguration(
  meta: MetaConfiguration(
    title: 'Mistery',
    author: 'Stephan E.G. Veenstra',
    description: 'A murder mystery example.',
    version: Version(0, 1, 0),
  ),
  items: [],
  locations: [
    LocationConfiguration(
      id: 'intro_1',
      name: 'Intro',
      description: [
        DescriptionConfiguration(
            text: 'It was a quite evening at the police station.'),
        DescriptionConfiguration(text: 'But then, the phone rang...'),
      ],
      actions: [
        ActionConfiguration(
          label: 'Answer the phone',
          effect: 'location = intro_2',
          type: ActionType.use,
          message:
              'It\'s your friend, and colleague Ben.\nHe\'s at a crime scene and needs your help.\n\nSolving murders is your speciality after all.',
        ),
      ],
    ),
    LocationConfiguration(
      id: 'intro_2',
      name: 'Intro',
      description: [
        DescriptionConfiguration(
            text:
                'You\'ve received a call from Ben who needs your murder-solving skills at his crime scene.'),
        DescriptionConfiguration(text: 'This is where the story begins...'),
      ],
      actions: [
        ActionConfiguration(
          type: ActionType.navigate,
          label: 'Start',
          effect: 'location = your_desk',
        ),
      ],
    ),
    LocationConfiguration(
      id: 'your_desk',
      name: 'Your desk (Police Station)',
      description: [
        DescriptionConfiguration(text: 'You\'re at your desk.'),
        DescriptionConfiguration(text: 'It\'s quite at the police station.'),
        DescriptionConfiguration(text: 'There is a nice smell of food.'),
      ],
      actions: [],
    ),
  ],
);
