part of 'clicker_bloc.dart';

class ClickerState {
  ClickerState({
    this.interval = 1000,
    this.repeat = 10,
    this.doubleClick = false,
    required this.clicks,
  });

  int interval;
  int repeat;
  bool doubleClick;
  List<Click> clicks;

  ClickerState copyWith({
    int? interval,
    int? repeat,
    bool? doubleClick,
    List<Click>? clicks,
  }) {
    return ClickerState(
      interval: interval ?? this.interval,
      repeat: repeat ?? this.repeat,
      doubleClick: doubleClick ?? this.doubleClick,
      clicks: clicks ?? this.clicks,
    );
  }
}
