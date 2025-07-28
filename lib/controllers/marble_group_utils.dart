import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/marble_model.dart';

class MarbleGroupUtils {
  static List<int> findConnectedMarbles(RxList<MarbleModel> marbles, int index, {double marbleSize = 30}) {
    final visited = <int>{};
    final queue = <int>[index];

    while (queue.isNotEmpty) {
      final current = queue.removeLast();
      if (!visited.add(current)) continue;

      for (int i = 0; i < marbles.length; i++) {
        if (i != current && !visited.contains(i)) {
          final distance = (marbles[i].position - marbles[current].position).distance;
          if (distance <= marbleSize) queue.add(i);
        }
      }
    }

    return visited.toList();
  }

  static List<Offset> generateGridPositions(int count, Offset center, {double spacing = 25}) {
    final cols = (count <= 2) ? count : (count / 2).ceil();
    final rows = (count <= 2) ? 1 : 2;

    return List.generate(count, (i) {
      final row = i ~/ cols;
      final col = i % cols;
      final dx = (col - (cols - 1) / 2) * spacing;
      final dy = (row - (rows - 1) / 2) * spacing;
      return center.translate(dx, dy);
    });
  }

  static Offset averageOffset(Iterable<Offset> offsets) {
    final sum = offsets.reduce((a, b) => a + b);
    return sum / offsets.length.toDouble();
  }

  static Rect calculateGroupBounds(List<MapEntry<int, MarbleModel>> group) {
    final positions = group.map((e) => e.value.position).toList();
    final minX = positions.map((p) => p.dx).reduce(min);
    final maxX = positions.map((p) => p.dx).reduce(max);
    final minY = positions.map((p) => p.dy).reduce(min);
    final maxY = positions.map((p) => p.dy).reduce(max);
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }
}
