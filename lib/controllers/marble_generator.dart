import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/marble_model.dart';

class MarbleGenerator {
  static void generate(
      RxList<MarbleModel> marbles, {
        required int count,
        required double maxWidth,
        required double maxHeight,
        double minDistance = 50,
        double marbleSize = 30,
        double leftPadding = 70,
      }) {
    marbles.clear();
    final random = Random();
    final positions = <Offset>[];
    int tries = 0;

    while (positions.length < count && tries < 10000) {
      final dx = leftPadding +
          random.nextDouble() * (maxWidth - leftPadding - marbleSize);
      final dy = random.nextDouble() * (maxHeight - marbleSize);
      final candidate = Offset(dx, dy);

      if (positions.every((other) => (candidate - other).distance >= minDistance)) {
        positions.add(candidate);
      }
      tries++;
    }

    marbles.assignAll(
      positions.map((pos) => MarbleModel(position: pos)).toList(),
    );
  }
}
