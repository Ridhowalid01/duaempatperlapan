import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/color_card_area.dart';
import '../models/marble_model.dart';

class MarbleController extends GetxController {
  final marbles = <MarbleModel>[].obs;
  final double marbleSize = 30.0;
  final double spacing = 25.0;
  final double leftPadding = 70.0;
  int _groupCounter = 0;
  List<MapEntry<int, MarbleModel>>? _draggingGroup;

  void generateRandomMarbles({
    required int count,
    required double maxWidth,
    required double maxHeight,
    double minDistance = 50,
  }) {
    marbles.clear();
    final random = Random();
    final positions = <Offset>[];
    int tries = 0;

    while (positions.length < count && tries < 10000) {
      final dx =
          leftPadding +
          random.nextDouble() * (maxWidth - leftPadding - marbleSize);
      final dy = random.nextDouble() * (maxHeight - marbleSize);
      final candidate = Offset(dx, dy);

      if (positions.every(
        (other) => (candidate - other).distance >= minDistance,
      )) {
        positions.add(candidate);
      }

      tries++;
    }

    marbles.assignAll(
      positions.map((pos) => MarbleModel(position: pos)).toList(),
    );
  }

  void updatePosition(int index, Offset newPosition) {
    final marble = marbles[index];
    final connected = _findConnectedMarbles(index);
    final groupId = connected
        .map((i) => marbles[i].groupId)
        .whereType<int>()
        .fold<int>(_generateGroupId(), (prev, val) => min(prev, val));

    for (var i in connected) {
      marbles[i].groupId = groupId;
    }

    final group = marbles
        .asMap()
        .entries
        .where((e) => e.value.groupId == groupId)
        .toList();
    final oldCenter = _averageOffset(group.map((e) => e.value.position));
    final anchorOffset = marble.position - oldCenter;

    final positions = _generateGridPositions(group.length, oldCenter);
    for (int i = 0; i < group.length; i++) {
      marbles[group[i].key].position = positions[i];
    }

    final newCenter = _averageOffset(group.map((e) => e.value.position));
    final delta = newPosition - (newCenter + anchorOffset);

    for (final entry in group) {
      marbles[entry.key].position += delta;
    }

    _draggingGroup = group;
    marbles.refresh();
  }

  void endDrag() {
    if (_draggingGroup != null) {
      final groupId = _draggingGroup!.first.value.groupId!;
      final group = marbles
          .asMap()
          .entries
          .where((e) => e.value.groupId == groupId)
          .toList();

      final leftMost = group.map((e) => e.value.position.dx).reduce(math.min);
      final topMost = group.map((e) => e.value.position.dy).reduce(math.min);
      final touchPoint = Offset(leftMost, topMost);

      bool isInCard = false;
      for (final area in colorCardAreas) {
        if (area.rect.contains(touchPoint)) {
          for (final entry in group) {
            marbles[entry.key].color = area.color;
          }
          isInCard = true;
          break;
        }
      }

      if (!isInCard) {
        for (final entry in group) {
          marbles[entry.key].color = marbles[entry.key].defaultColor;
        }
      }

      final center = _averageOffset(group.map((e) => e.value.position));
      final positions = _generateGridPositions(group.length, center);
      for (int i = 0; i < group.length; i++) {
        marbles[group[i].key].position = positions[i];
      }

      _draggingGroup = null;
      marbles.refresh();
    }
  }

  List<int> _findConnectedMarbles(int index) {
    final visited = <int>{};
    final queue = <int>[index];

    while (queue.isNotEmpty) {
      final current = queue.removeLast();
      if (!visited.add(current)) continue;

      for (int i = 0; i < marbles.length; i++) {
        if (i != current && !visited.contains(i)) {
          final distance =
              (marbles[i].position - marbles[current].position).distance;
          if (distance <= marbleSize) queue.add(i);
        }
      }
    }

    return visited.toList();
  }

  List<Offset> _generateGridPositions(int count, Offset center) {
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

  Offset _averageOffset(Iterable<Offset> offsets) {
    final sum = offsets.reduce((a, b) => a + b);
    return sum / offsets.length.toDouble();
  }

  int _generateGroupId() => _groupCounter++;

  final List<ColorCardArea> colorCardAreas = [
    ColorCardArea(color: Colors.orange, rect: Rect.zero),
    ColorCardArea(color: Colors.yellow, rect: Rect.zero),
    ColorCardArea(color: Colors.cyan, rect: Rect.zero),
  ];

  void updateCardRect(int index, Rect rect) {
    if (index >= 0 && index < colorCardAreas.length) {
      colorCardAreas[index] = colorCardAreas[index].copyWith(rect: rect);
    }
  }
}
