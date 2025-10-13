part of 'clicker_bloc.dart';

final class ClickerState {
  ClickerState({
    this.interval = 1000,
    this.repeat = 10,
    this.doubleClick = false,
    this.swipeMode = false,
    required this.clicks,
  });

  int interval;
  int repeat;
  bool doubleClick;
  bool swipeMode;
  List<Click> clicks;

  ClickerState copyWith({
    int? interval,
    int? repeat,
    bool? doubleClick,
    bool? swipeMode,
    List<Click>? clicks,
  }) {
    return ClickerState(
      interval: interval ?? this.interval,
      repeat: repeat ?? this.repeat,
      doubleClick: doubleClick ?? this.doubleClick,
      swipeMode: swipeMode ?? this.swipeMode,
      clicks: clicks ?? this.clicks,
    );
  }
}
