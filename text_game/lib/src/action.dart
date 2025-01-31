enum ActionType {
  navigate,
  use,
}

abstract class Action {
  String get label;
  ActionType get type;
}
