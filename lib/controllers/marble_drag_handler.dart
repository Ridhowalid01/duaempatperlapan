import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/marble_model.dart';
import '../models/color_card_area.dart';
import 'marble_group_utils.dart';

class MarbleDragHandler {
  static List<MapEntry<int, MarbleModel>>? _draggingGroup;
  static int _groupCounter = 0;

  static void update(RxList<MarbleModel> marbles, int index, Offset newPosition) {
    final marble = marbles[index];
    final connected = MarbleGroupUtils.findConnectedMarbles(marbles, index);
    final groupId = connected
        .map((i) => marbles[i].groupId)
        .whereType<int>()
        .fold<int>(_generateGroupId(), (prev, val) => prev < val ? prev : val);

    for (var i in connected) {
      marbles[i].groupId = groupId;
    }

    final group = marbles
        .asMap()
        .entries
        .where((e) => e.value.groupId == groupId)
        .toList();

    final oldCenter = MarbleGroupUtils.averageOffset(group.map((e) => e.value.position));
    final anchorOffset = marble.position - oldCenter;

    final positions = MarbleGroupUtils.generateGridPositions(group.length, oldCenter);
    for (int i = 0; i < group.length; i++) {
      marbles[group[i].key].position = positions[i];
    }

    final newCenter = MarbleGroupUtils.averageOffset(group.map((e) => e.value.position));
    final delta = newPosition - (newCenter + anchorOffset);

    for (final entry in group) {
      marbles[entry.key].position += delta;
    }

    _draggingGroup = group;
    marbles.refresh();
  }

  static void endDrag(
      RxList<MarbleModel> marbles,
      RxList<ColorCardArea> colorCardAreas,
      ) {
    if (_draggingGroup != null) {
      final group = _draggingGroup!;
      final groupBounds = MarbleGroupUtils.calculateGroupBounds(group);
      bool isInCard = false;
      Color? matchedColor;

      for (final area in colorCardAreas) {
        final expandedRect = area.rect.inflate(5);
        if (expandedRect.overlaps(groupBounds)) {
          matchedColor = area.color;
          isInCard = true;
          break;
        }
      }

      for (final entry in group) {
        marbles[entry.key].color = isInCard
            ? matchedColor!
            : marbles[entry.key].defaultColor;
      }

      final center = MarbleGroupUtils.averageOffset(group.map((e) => e.value.position));
      final positions = MarbleGroupUtils.generateGridPositions(group.length, center);
      for (int i = 0; i < group.length; i++) {
        marbles[group[i].key].position = positions[i];
      }

      _draggingGroup = null;
      marbles.refresh();
    }
  }

  static int _generateGroupId() => _groupCounter++;
}
