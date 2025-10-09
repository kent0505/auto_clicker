part of 'clicker_bloc.dart';

@immutable
sealed class ClickerEvent {}

final class ChangeClickerPosition extends ClickerEvent {
  ChangeClickerPosition(this.x, this.y);

  final double x;
  final double y;
}
