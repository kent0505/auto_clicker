part of 'clicker_bloc.dart';

final class ClickerState {
  ClickerState({
    this.interval = 1000,
    this.repeat = 10,
    this.doubleClick = false,
    this.swipeMode = false,
    required this.clicks,
    this.swipes = const [],
  });

  int interval;
  int repeat;
  bool doubleClick;
  bool swipeMode;
  List<Click> clicks;
  List<Swipe> swipes;

  ClickerState copyWith({
    int? interval,
    int? repeat,
    bool? doubleClick,
    bool? swipeMode,
    List<Click>? clicks,
    List<Swipe>? swipes,
  }) {
    return ClickerState(
      interval: interval ?? this.interval,
      repeat: repeat ?? this.repeat,
      doubleClick: doubleClick ?? this.doubleClick,
      swipeMode: swipeMode ?? this.swipeMode,
      clicks: clicks ?? this.clicks,
      swipes: swipes ?? this.swipes,
    );
  }
}
