import 'package:text_game/text_game.dart';

class Condition {
  Condition(this.expression);

  final String expression;

  bool evaluate(TextGameSession session) {
    final isNegated = expression[0] == '!';

    final expr = isNegated ? expression.substring(1) : expression;

    final split = expr.split('.');
    final namesspace = split[0];
    final property = split[1];

    switch (namesspace) {
      case 'inventory':
        final item =
            session.game.items.firstWhere((element) => element.id == property);

        final hasItem = session.progress.inventory.containsKey(item);

        return isNegated ? !hasItem : hasItem;

      default:
        throw Exception('Unknown namespace: $namesspace');
    }
  }
}
