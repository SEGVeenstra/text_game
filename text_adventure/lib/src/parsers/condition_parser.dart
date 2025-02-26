class ConditionParser {
  final Map<String, dynamic> variables;
  final Map<String, int> inventory;

  ConditionParser({required this.variables, required this.inventory});

  bool evaluate(String condition) {
    // Remove all whitespace for simpler parsing
    final cleanedCondition = condition.replaceAll(RegExp(r'\s+'), '');
    return _evaluateExpression(cleanedCondition);
  }

  bool _evaluateExpression(String expression) {
    expression = expression.trim();

    // Handle parentheses: only strip outer parentheses if the expression is fully wrapped in them
    if (expression.startsWith('(') && expression.endsWith(')')) {
      final innerExpression =
          expression.substring(1, expression.length - 1).trim();
      if (innerExpression.isNotEmpty) {
        expression = innerExpression;
      }
    }

    return _evaluateLogical(expression);
  }

  bool _evaluateLogical(String expression) {
    // Handle OR (`||`) operator
    if (expression.contains('||')) {
      final parts = expression.split('||').map((e) => e.trim()).toList();
      return parts.any(_evaluateLogical);
    }

    // Handle AND (`&&`) operator
    if (expression.contains('&&')) {
      final parts = expression.split('&&').map((e) => e.trim()).toList();
      return parts.every(_evaluateLogical);
    }

    return _evaluateComparison(expression);
  }

  bool _evaluateComparison(String expression) {
    // Match comparison operators like ==, !=, <, >, <=, >=
    final comparisonRegex = RegExp(r'(.+?)(==|!=|<=|>=|<|>)(.+)');
    final match = comparisonRegex.firstMatch(expression);

    if (match != null) {
      final left = match.group(1)!.trim();
      final operator = match.group(2)!;
      final right = match.group(3)!.trim();

      final leftValue = _getValue(left);
      final rightValue = _getValue(right);

      switch (operator) {
        case '==':
          return leftValue == rightValue;
        case '!=':
          return leftValue != rightValue;
        case '<':
          return leftValue is num &&
              rightValue is num &&
              leftValue < rightValue;
        case '>':
          return leftValue is num &&
              rightValue is num &&
              leftValue > rightValue;
        case '<=':
          return leftValue is num &&
              rightValue is num &&
              leftValue <= rightValue;
        case '>=':
          return leftValue is num &&
              rightValue is num &&
              leftValue >= rightValue;
      }
    }

    throw Exception(
        "Invalid expression: $expression. A comparison operator is required.");
  }

  dynamic _getValue(String identifier) {
    final match = RegExp(r'(\w+)\.(\w+)').firstMatch(identifier);
    if (match != null) {
      final namespace = match.group(1)!;
      final key = match.group(2)!;

      if (namespace == "inventory") {
        return inventory[key] ?? 0; // Default inventory item amount is 0
      } else if (namespace == "vars") {
        return variables[key];
      } else {
        throw Exception("Unknown namespace: $namespace");
      }
    }

    // Try parsing as number or boolean
    if (RegExp(r'^\d+$').hasMatch(identifier)) {
      return int.parse(identifier);
    } else if (RegExp(r'^\d+\.\d+$').hasMatch(identifier)) {
      return double.parse(identifier);
    } else if (identifier == "true") {
      return true;
    } else if (identifier == "false") {
      return false;
    }

    throw Exception("Unknown identifier: $identifier");
  }
}
