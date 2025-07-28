import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/marble_controller.dart';

class CardAreasOverlayWidget extends StatelessWidget {
  const CardAreasOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MarbleController>();

    return Obx(() {
      final areas = controller.colorCardAreas;

      if (areas.isEmpty) {
        return const SizedBox();
      }

      return Stack(
        children: areas.map((area) {
          return Positioned(
            left: area.rect.left,
            top: area.rect.top,
            width: area.rect.width,
            height: area.rect.height,
            child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: area.color, width: 2),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
