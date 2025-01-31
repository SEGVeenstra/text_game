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
    // Handle negation at the beginning of the expression
    final isNegated = expression.startsWith('!');
    final rawExpression = isNegated ? expression.substring(1) : expression;

    // Handle parentheses by evaluating the innermost group first
    final parenthesisRegex = RegExp(r'\(([^()]+)\)');
    String resolvedExpression = rawExpression;
    while (parenthesisRegex.hasMatch(resolvedExpression)) {
      resolvedExpression =
          resolvedExpression.replaceAllMapped(parenthesisRegex, (match) {
        final innerExpression = match.group(1)!;
        final innerResult = _evaluateExpression(innerExpression);
        return innerResult ? 'true' : 'false';
      });
    }

    // Evaluate the remaining logical expression
    final result = _evaluateLogical(resolvedExpression);

    // Apply negation if needed
    return isNegated ? !result : result;
  }

  bool _evaluateLogical(String expression) {
    // If the expression is "true" or "false", return it as a boolean
    if (expression.trim() == 'true') return true;
    if (expression.trim() == 'false') return false;

    // Existing logic for evaluating comparison and logical operators
    final orParts = expression.split('||');
    for (var orPart in orParts) {
      final andParts = orPart.split('&&');
      bool andResult = true;
      for (var andPart in andParts) {
        // Evaluate each comparison individually
        final comparisonResult = _evaluateComparison(andPart.trim());
        andResult = andResult && comparisonResult;
      }
      if (andResult) return true;
    }
    return false;
  }

  bool _evaluateComparison(String expression) {
    // Match comparison operators like ==, !=, <, >, <=, >=
    final comparisonRegex = RegExp(r'(==|!=|<=|>=|<|>)');
    final match = comparisonRegex.firstMatch(expression);

    if (match != null) {
      final operator = match.group(0)!;
      final parts = expression.split(operator);
      final left = _getValue(parts[0]);
      final right = _getValue(parts[1]);

      switch (operator) {
        case '==':
          return left == right;
        case '!=':
          return left != right;
        case '<':
          return left < right;
        case '>':
          return left > right;
        case '<=':
          return left <= right;
        case '>=':
          return left >= right;
        default:
          throw Exception("Unknown comparison operator: $operator");
      }
    }

    // If no comparison, treat as shorthand
    return _evaluateShorthand(expression);
  }

  bool _evaluateShorthand(String expression) {
    // Check for negation
    final isNegated = expression.startsWith('!');
    final rawExpression = isNegated ? expression.substring(1) : expression;

    // Match inventory or variable shorthand
    final match = RegExp(r'(\w+)\.(\w+)').firstMatch(rawExpression);
    if (match != null) {
      final namespace = match.group(1)!;
      final key = match.group(2)!;

      bool result = false;

      if (namespace == "inventory") {
        // Inventory shorthand: true if item count > 0
        result = (inventory[key] ?? 0) > 0;
      } else if (namespace == "vars") {
        // Variable shorthand: evaluate "truthiness"
        final value = variables[key];
        result = _isTruthy(value);
      } else {
        throw Exception("Unknown namespace: $namespace");
      }

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
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) return value.isNotEmpty;
    return false; // null or other types are "falsey"
  }
}
