part of 'clicker_bloc.dart';

@immutable
sealed class ClickerEvent {}

final class ChangeInterval extends ClickerEvent {
  ChangeInterval({required this.interval});

  final int interval;
}

final class ChangeRepeat extends ClickerEvent {
  ChangeRepeat({required this.repeat});

  final int repeat;
}

final class ChangeEndless extends ClickerEvent {}

final class ChangeDoubleClick extends ClickerEvent {}

final class ChangeSwipeMode extends ClickerEvent {}

final class ResetClicks extends ClickerEvent {}

final class AddClick extends ClickerEvent {}

final class RemoveClick extends ClickerEvent {
  RemoveClick({required this.click});

  final Click click;
}

final class MoveClick extends ClickerEvent {
  MoveClick({required this.click});

  final Click click;
}
