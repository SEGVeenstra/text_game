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
    expression = expression.trim(); // Trim spaces

    // Handle parentheses: only strip outer parentheses if the expression is fully wrapped in them
    if (expression.startsWith('(') && expression.endsWith(')')) {
      final innerExpression =
          expression.substring(1, expression.length - 1).trim();
      if (innerExpression.isNotEmpty) {
        expression = innerExpression;
      }
    }

    // Directly evaluate the logical expression
    return _evaluateLogical(expression);
  }

  bool _evaluateLogical(String expression) {
    // If the expression is "true" or "false", return it as a boolean
    if (expression.trim() == 'true') return true;
    if (expression.trim() == 'false') return false;

    // Handle negation at the term level
    final orParts = expression.split('||');
    for (var orPart in orParts) {
      final andParts = orPart.split('&&');
      bool andResult = true;
      for (var andPart in andParts) {
        andPart = andPart.trim();

        // Handle negation before each term
        final isNegated = andPart.startsWith('!');
        final rawExpression = isNegated ? andPart.substring(1) : andPart;

        // Evaluate the actual comparison
        final comparisonResult = _evaluateComparison(rawExpression);

        // Apply negation correctly
        andResult =
            andResult && (isNegated ? !comparisonResult : comparisonResult);
      }
      if (andResult) return true;
    }
    return false;
  }

  bool _evaluateComparison(String expression) {
    // Handle negation at the start of an expression
    final isNegated = expression.startsWith('!');
    final rawExpression = isNegated ? expression.substring(1) : expression;

    // Match comparison operators like ==, !=, <, >, <=, >=
    final comparisonRegex = RegExp(r'(==|!=|<=|>=|<|>)');
    final match = comparisonRegex.firstMatch(rawExpression);

    if (match != null) {
      final operator = match.group(0)!;
      final parts = rawExpression.split(operator);
      final left = _getValue(parts[0]);
      final right = _getValue(parts[1]);

      bool result;
      switch (operator) {
        case '==':
          result = left == right;
          break;
        case '!=':
          result = left != right;
          break;
        case '<':
          result = left < right;
          break;
        case '>':
          result = left > right;
          break;
        case '<=':
          result = left <= right;
          break;
        case '>=':
          result = left >= right;
          break;
        default:
          throw Exception("Unknown comparison operator: $operator");
      }

      return isNegated ? !result : result;
    }

    // If no comparison, treat as shorthand
    return isNegated
        ? !_evaluateShorthand(rawExpression)
        : _evaluateShorthand(rawExpression);
  }

  bool _evaluateShorthand(String expression) {
    expression = expression.trim(); // ✅ Trim first!

    final isNegated = expression.startsWith('!');
    final rawExpression = isNegated
        ? expression.substring(1).trim()
        : expression; // ✅ Trim again after removing `!`

    final match = RegExp(r'(\w+)\.(\w+)').firstMatch(rawExpression);
    if (match != null) {
      final namespace = match.group(1)!;
      final key = match.group(2)!;

      dynamic value;
      if (namespace == "inventory") {
        value = inventory[key];
      } else if (namespace == "vars") {
        value = variables[key];
      } else {
        throw Exception("Unknown namespace: $namespace");
      }

      bool result = _isTruthy(value);

      // Debug logs
      print(
          "Evaluating: $expression -> Raw Value: $value -> Truthy: $result -> isNegated: $isNegated");

      return isNegated ? !result : result;
    }

    throw Exception("Invalid shorthand syntax: $expression");
  }

  dynamic _getValue(String identifier) {
    // Try to resolve variables and inventory
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

    // If not a variable, attempt to parse as constant (int, double, or bool)
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

  bool _isTruthy(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0; // Convert nonzero numbers to true
    if (value is String) return value.isNotEmpty;
    return true; // Any non-null value is truthy
  }
}
