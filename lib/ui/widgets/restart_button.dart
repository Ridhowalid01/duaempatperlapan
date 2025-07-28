import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/marble_controller.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 48,
      onPressed: () {
        final controller = Get.find<MarbleController>();
        final size = controller.dragAreaSize.value;

        controller.restartAllMarbles(
          count: 24,
          maxWidth: size.width,
          maxHeight: size.height,
        );
        Get.snackbar(
          "🔄 Restart",
          "Semua kelereng telah direset",
          backgroundColor: Colors.purpleAccent,
        );
      },
      icon: Icon(Icons.restart_alt, color: Colors.white),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.purple),
        shape: WidgetStateProperty.all(CircleBorder()),
        padding: WidgetStateProperty.all(EdgeInsets.all(2)),
      ),
    );
  }
}

