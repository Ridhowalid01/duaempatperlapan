import 'dart:math';
import 'package:flutter/material.dart';

class MarblesAreaWidget extends StatelessWidget {
  const MarblesAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    const int count = 24;
    const double size = 35;
    const double minDistance = 45;

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          List<Offset> positions = [];

          int tries = 0;

          while (positions.length < count && tries < 10000) {
            final left = random.nextDouble() * (maxWidth - size);
            final top = random.nextDouble() * (maxHeight - size);
            final candidate = Offset(left, top);

            // Cek apakah posisi ini cukup jauh dari semua posisi yang sudah ada
            bool hasCollision = positions.any(
              (other) => (candidate - other).distance < minDistance,
            );

            if (!hasCollision) {
              positions.add(candidate);
            }

            tries++;
          }

          return Stack(
            children: positions.map((offset) {
              return Positioned(
                left: offset.dx,
                top: offset.dy,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
