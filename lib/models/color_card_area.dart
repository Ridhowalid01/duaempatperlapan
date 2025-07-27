import 'package:flutter/material.dart';

class ColorCardArea {
  final Color color;
  final Rect rect;

  const ColorCardArea({required this.color, required this.rect});

  ColorCardArea copyWith({Color? color, Rect? rect}) {
    return ColorCardArea(color: color ?? this.color, rect: rect ?? this.rect);
  }
}