import 'package:text_game/text_game.dart';

class ExpressionEffect extends Effect {
  const ExpressionEffect({
    required this.expression,
  });

  final String expression;

  void apply(TextGameSession session) {
    final split = expression.split(' ');
    print(split);
    final opperator = split[1];
    final value = split[2];
    final path = split[0].split('.');
    final namespace = path[0];
    final property = path[1];

    switch (namespace) {
      case 'vars':
        final variable = session.progress.variables[property] ?? 0;
        switch (opperator) {
          case '=':
            session.progress.setVariable(property, value);
            break;
          case '+':
            session.progress.setVariable(property, variable + value);
            break;
          case '-':
            session.progress.setVariable(property, variable - value);
            break;
          case '*':
            session.progress.setVariable(property, variable * value);
            break;
          case '/':
            session.progress.setVariable(property, variable / value);
            break;
          default:
            throw Exception('Unknown opperator: $opperator');
        }
        break;
      default:
        throw Exception('Unknown namespace: $namespace');
    }
  }
}
