import 'package:duaempatperlapan/ui/widgets/marbles_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/marble_controller.dart';
import 'card_on_edge_widget.dart';

class DragAndDropAreaWidget extends StatelessWidget {
  const DragAndDropAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MarbleController());
    return Expanded(
      flex: 3,
      child: Stack(
        children: [
          Positioned(left: 0, top: 0, bottom: 0, child: CardOnEdgeWidget()),
          Positioned.fill(child: MarblesAreaWidget()),
        ],
      ),
    );
  }
}
