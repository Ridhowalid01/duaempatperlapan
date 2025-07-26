import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/marble_model.dart';

class MarbleController extends GetxController {
  final marbles = <MarbleModel>[].obs;
  double marbleSize = 35.0;
  int _groupCounter = 0;

  List<MapEntry<int, MarbleModel>>? _draggingGroup;

  double get spacing => marbleSize * 0.85;

  void generateRandomMarbles({
    required int count,
    required double maxWidth,
    required double maxHeight,
    double size = 35,
    double minDistance = 45,
  }) {
    marbles.clear();
    final random = Random();
    List<Offset> positions = [];
    int tries = 0;

    while (positions.length < count && tries < 10000) {
      final candidate = Offset(
        random.nextDouble() * (maxWidth - size),
        random.nextDouble() * (maxHeight - size),
      );

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
    final connectedIndices = _findConnectedMarbles(index);
    final groupId = _mergeGroups(connectedIndices);

    final oldCenter = _calculateGroupCenter(_getMarblesByGroup(groupId));
    final anchorOffset = marble.position - oldCenter;

    rearrangeGroup(groupId);

    final newCenter = _calculateGroupCenter(_getMarblesByGroup(groupId));
    final draggedMarbleNewPos = newCenter + anchorOffset;
    final delta = newPosition - draggedMarbleNewPos;

    _moveGroup(groupId, delta);

    _draggingGroup = _getMarblesByGroup(groupId);
    marbles.refresh();
  }

  void endDrag() {
    if (_draggingGroup != null) {
      rearrangeGroup(_draggingGroup!.first.value.groupId!);
      _draggingGroup = null;
    }
  }

  int _mergeGroups(List<int> indices) {
    final groupIds = indices
        .map((i) => marbles[i].groupId)
        .whereType<int>()
        .toSet();
    final groupId = groupIds.isNotEmpty
        ? groupIds.reduce(min)
        : _generateGroupId();
    for (var i in indices) {
      marbles[i].groupId = groupId;
    }
    return groupId;
  }

  void _moveGroup(int groupId, Offset delta) {
    for (final entry in _getMarblesByGroup(groupId)) {
      marbles[entry.key].position += delta;
    }
  }

  void rearrangeGroup(int groupId) {
    final groupMarbles = _getMarblesByGroup(groupId);
    if (groupMarbles.length <= 1) return;

    final center = _calculateGroupCenter(groupMarbles);
    final positions = _generateRearrangedPositions(groupMarbles.length, center);

    for (int i = 0; i < groupMarbles.length; i++) {
      marbles[groupMarbles[i].key].position = positions[i];
    }
  }

  List<MapEntry<int, MarbleModel>> _getMarblesByGroup(int groupId) {
    return marbles
        .asMap()
        .entries
        .where((e) => e.value.groupId == groupId)
        .toList();
  }

  Offset _calculateGroupCenter(List<MapEntry<int, MarbleModel>> group) {
    final sum = group.map((e) => e.value.position).reduce((a, b) => a + b);
    return sum / group.length.toDouble();
  }

  List<Offset> _generateRearrangedPositions(int count, Offset center) {
    if (count == 2) {
      return [
        center.translate(-spacing / 2, 0),
        center.translate(spacing / 2, 0),
      ];
    } else if (count == 3) {
      return [
        center.translate(-spacing / 2, spacing / 2),
        center.translate(spacing / 2, spacing / 2),
        center.translate(0, -spacing / 1.5),
      ];
    } else if (count == 4) {
      return [
        center.translate(-spacing / 2, -spacing / 2),
        center.translate(spacing / 2, -spacing / 2),
        center.translate(-spacing / 2, spacing / 2),
        center.translate(spacing / 2, spacing / 2),
      ];
    } else {
      return _generateGridPositions(count, center, spacing);
    }
  }

  List<Offset> _generateGridPositions(
    int count,
    Offset center,
    double spacing,
  ) {
    final cols = (count <= 2) ? count : (count / 2.0).ceil();
    final rows = (count <= 2) ? 1 : 2;
    return List.generate(count, (i) {
      final row = i ~/ cols;
      final col = i % cols;
      final dx = (col - (cols - 1) / 2) * spacing;
      final dy = (row - (rows - 1) / 2) * spacing;
      return center.translate(dx, dy);
    });
  }

  List<int> _findConnectedMarbles(int index) {
    final touched = <int>{};
    final toVisit = <int>[index];

    while (toVisit.isNotEmpty) {
      final current = toVisit.removeLast();
      if (!touched.add(current)) continue;

      for (int i = 0; i < marbles.length; i++) {
        if (i == current || touched.contains(i)) continue;
        final distance =
            (marbles[i].position - marbles[current].position).distance;
        if (distance <= marbleSize) toVisit.add(i);
      }
    }

    return touched.toList();
  }

  int _generateGroupId() => _groupCounter++;
}
