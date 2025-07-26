import 'package:duaempatperlapan/ui/widgets/marbles_area_widget.dart';
import 'package:flutter/material.dart';

import 'card_on_edge_widget.dart';

class DragAndDropAreaWidget extends StatelessWidget {
  const DragAndDropAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 15,
        children: [CardOnEdgeWidget(), MarblesAreaWidget()],
      ),
    );
  }
}
