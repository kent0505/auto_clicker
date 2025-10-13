class Click {
  Click({
    this.x = 100,
    this.y = 100,
    this.clicked = false,
  });

  double x;
  double y;
  bool clicked;

  Click copyWith({
    double? x,
    double? y,
    bool? clicked,
  }) {
    return Click(
      x: x ?? this.x,
      y: y ?? this.y,
      clicked: clicked ?? this.clicked,
    );
  }
}
