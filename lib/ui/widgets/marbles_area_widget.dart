import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/marble_controller.dart';

class MarblesAreaWidget extends StatelessWidget {
  const MarblesAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final MarbleController controller = Get.put(MarbleController());
    final MarbleController controller = Get.put(MarbleController());


    return LayoutBuilder(
      builder: (context, constraints) {
        if (controller.marbles.isEmpty) {
          controller.generateRandomMarbles(
            count: 24,
            maxWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight,
          );
        }

        return Obx(() {
          return Stack(
            children: List.generate(controller.marbles.length, (index) {
              final marble = controller.marbles[index];

              return Positioned(
                left: marble.position.dx,
                top: marble.position.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final newPos = marble.position + details.delta;

                    final clampedX = newPos.dx.clamp(
                      0.0,
                      constraints.maxWidth - 35.0,
                    ).toDouble();
                    final clampedY = newPos.dy.clamp(
                      0.0,
                      constraints.maxHeight - 35.0,
                    ).toDouble();

                    controller.updatePosition(
                      index,
                      Offset(clampedX, clampedY),
                    );
                  },
                  onPanEnd: (_) {
                    controller.endDrag();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: marble.color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                ),
              );
            }),
          );
        });
      },
    );
  }
}
