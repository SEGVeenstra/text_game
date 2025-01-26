import 'dart:io';

import 'package:text_game/text_game.dart';

void main() {
  final locations = [
    Location(
      id: 'roomA',
      name: 'Room A',
      description: 'You are in room A.',
      exits: ['roomB'],
    ),
    Location(
      id: 'roomB',
      name: 'Room B',
      description: 'You are in room B.',
      exits: ['roomA'],
    ),
  ];
  final progress = TextGameProgress();
  final game = TextGame(
    locations: locations,
  );
  final session = TextGameSession(
    game: game,
    progress: progress,
  );

  printCurrentLocation(session);

  session.go('roomB');

  printCurrentLocation(session);
}

void printCurrentLocation(TextGameSession session) {
  final currentLocation = session.currentLocation;
  final exits = session.currentExits;
  print(currentLocation.description);
  print('');
  print('Exits:');
  for (var exit in exits) {
    print('  - ${exit.name}');
  }
}
