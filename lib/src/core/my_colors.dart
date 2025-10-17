import 'package:flutter/material.dart';

final class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.accent,
    required this.bg,
    required this.error,
    required this.tile,
    required this.text,
    required this.text2,
  });

  final Color accent;
  final Color bg;
  final Color error;
  final Color tile;
  final Color text;
  final Color text2;

  factory MyColors.dark() {
    return MyColors(
      accent: const Color(0xffBE7B72),
      bg: const Color(0xff37353E),
      error: const Color(0xffC63C51),
      tile: const Color(0xff44444E),
      text: const Color(0xffD3DAD9),
      text2: const Color(0xffD3DAD9).withValues(alpha: 0.4),
    );
  }

  factory MyColors.light() {
    return MyColors(
      accent: const Color(0xffE26B5A),
      bg: const Color(0xffF5F5F0),
      error: const Color(0xffF08787),
      tile: const Color(0xffE6D8C3),
      text: const Color(0xff1A1A1A),
      text2: const Color(0xff1A1A1A).withValues(alpha: 0.5),
    );
  }

  @override
  MyColors copyWith({
    Color? accent,
    Color? bg,
    Color? error,
    Color? tile,
    Color? text,
    Color? text2,
  }) {
    return MyColors(
      accent: accent ?? this.accent,
      bg: bg ?? this.bg,
      error: error ?? this.error,
      tile: tile ?? this.tile,
      text: text ?? this.text,
      text2: text2 ?? this.text2,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      accent: Color.lerp(accent, other.accent, t)!,
      bg: Color.lerp(bg, other.bg, t)!,
      error: Color.lerp(error, other.error, t)!,
      tile: Color.lerp(tile, other.tile, t)!,
      text: Color.lerp(text, other.text, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
    );
  }
}
