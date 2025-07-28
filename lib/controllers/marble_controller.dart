import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/marble_model.dart';
import '../models/color_card_area.dart';
import '../controllers/marble_generator.dart';
import '../controllers/marble_drag_handler.dart';

class MarbleController extends GetxController {
  final marbles = <MarbleModel>[].obs;
  final double marbleSize = 30.0;
  final double spacing = 25.0;
  final double leftPadding = 70.0;
  final dragAreaSize = Rx<Size>(Size.zero);

  final colorCardAreas = <ColorCardArea>[
    ColorCardArea(color: Colors.orange, rect: Rect.zero),
    ColorCardArea(color: Colors.yellow, rect: Rect.zero),
    ColorCardArea(color: Colors.cyan, rect: Rect.zero),
  ].obs;

  void updateDragAreaSize(Size size) {
    dragAreaSize.value = size;
  }

  void generateRandomMarbles({
    required int count,
    required double maxWidth,
    required double maxHeight,
    double minDistance = 50,
  }) {
    MarbleGenerator.generate(
      marbles,
      count: count,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      minDistance: minDistance,
      marbleSize: marbleSize,
      leftPadding: leftPadding,
    );
  }

  void updatePosition(int index, Offset newPosition) {
    MarbleDragHandler.update(marbles, index, newPosition);
  }

  void endDrag() {
    MarbleDragHandler.endDrag(marbles, colorCardAreas);
  }

  void updateCardRect(int index, Rect rect) {
    if (index >= 0 && index < colorCardAreas.length) {
      colorCardAreas[index] = colorCardAreas[index].copyWith(rect: rect);
      if (index == colorCardAreas.length - 1) {
        colorCardAreas.refresh();
      }
    }
  }

  Map<Color, int> countMarblesByColor() {
    final colorCounts = <Color, int>{};

    for (var marble in marbles) {
      final color = marble.color;
      colorCounts[color] = (colorCounts[color] ?? 0) + 1;
    }

    return colorCounts;
  }

  List<Color> getIncorrectColors({int expectedCount = 8}) {
    final counts = countMarblesByColor();
    final incorrectColors = <Color>[];

    for (var area in colorCardAreas) {
      final actualCount = counts[area.color] ?? 0;
      if (actualCount != expectedCount) {
        incorrectColors.add(area.color);
      }
    }

    return incorrectColors;
  }

  void restartAllMarbles({
    required int count,
    required double maxWidth,
    required double maxHeight,
    double minDistance = 50,
  }) {
    marbles.clear();

    generateRandomMarbles(
      count: count,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      minDistance: minDistance,
    );
    marbles.refresh();
  }
}
