import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/marble_controller.dart';

class CardOnEdgeWidget extends StatelessWidget {
  const CardOnEdgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MarbleController controller = Get.find<MarbleController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (constraints.maxHeight > 0) {
            _calculatePositions(constraints, controller);
          }
        });

        return Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (i) {
              final cardArea = controller.colorCardAreas[i];
              final colors = _getCardColors(i);

              return _buildColorCard(
                index: i,
                mainColor: colors[0],
                shadowColor: colors[1],
                currentColor: cardArea.color,
              );
            }),
          ),
        );
      },
    );
  }

  void _calculatePositions(
    BoxConstraints constraints,
    MarbleController controller,
  ) {
    final availableHeight = constraints.maxHeight;
    final cardHeight = 100.0;
    final cardWidth = 50.0;
    final totalCardSpace = cardHeight * 3;
    final remainingSpace = availableHeight - totalCardSpace;
    final spaceBetween = remainingSpace > 0.0 ? remainingSpace / 2.0 : 0.0;

    final positions = [
      Rect.fromLTWH(0, 0, cardWidth, cardHeight),
      Rect.fromLTWH(0, cardHeight + spaceBetween, cardWidth, cardHeight),
      Rect.fromLTWH(
        0,
        cardHeight * 2 + spaceBetween * 2,
        cardWidth,
        cardHeight,
      ),
    ];

    // Update card rectangles in controller
    for (int i = 0; i < positions.length; i++) {
      controller.updateCardRect(i, positions[i]);
    }
  }

  List<Color> _getCardColors(int index) {
    switch (index) {
      case 0:
        return [Colors.orangeAccent, Colors.orange];
      case 1:
        return [Colors.yellowAccent, Colors.yellow];
      case 2:
        return [Colors.cyanAccent, Colors.cyan];
      default:
        return [Colors.grey, Colors.grey];
    }
  }

  Widget _buildColorCard({
    required int index,
    required Color mainColor,
    required Color shadowColor,
    required Color currentColor,
  }) {
    return Container(
      width: 50,
      height: 100,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: shadowColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
    );
  }
}
