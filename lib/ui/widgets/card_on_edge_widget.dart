import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/marble_controller.dart';

class CardOnEdgeWidget extends StatelessWidget {
  const CardOnEdgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldContext = context;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(3, (i) {
        final colors = [
          [Colors.orangeAccent, Colors.orange],
          [Colors.yellowAccent, Colors.yellow],
          [Colors.cyanAccent, Colors.cyan],
        ];
        return _buildColorCard(scaffoldContext, i, colors[i][0], colors[i][1]);
      }),
    );
  }
}

Widget _buildColorCard(
  BuildContext scaffoldContext,
  int index,
  Color mainColor,
  Color shadowColor,
) {
  final controller = Get.find<MarbleController>();

  return LayoutBuilder(
    builder: (context, constraints) {
      return Builder(
        builder: (ctx) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final renderBox = ctx.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              final offset = renderBox.localToGlobal(
                Offset.zero,
                ancestor: scaffoldContext.findRenderObject(),
              );
              final size = renderBox.size;
              controller.updateCardRect(index, offset & size);
            }
          });

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
        },
      );
    },
  );
}
