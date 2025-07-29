import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/marble_controller.dart';

class CheckAnswerButton extends StatelessWidget {
  const CheckAnswerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.green, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.green,
              spreadRadius: 2,
              blurRadius: 0,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            final controller = Get.find<MarbleController>();
            final wrongColors = controller.getIncorrectColors(expectedCount: 8);

            if (wrongColors.isEmpty) {
              Get.snackbar("✅ Benar!", "Semua kartu berisi 8 kelereng", backgroundColor: Colors.greenAccent);
            } else {
              final colorNames = wrongColors.map((c) {
                if (c == Colors.orange) return "🟠 Orange";
                if (c == Colors.yellow) return "🟡 Yellow";
                if (c == Colors.cyan) return "🔵 Cyan";
                return "Unknown";
              }).join(', ');

              Get.snackbar("❌ Salah", "Kartu tidak sesuai: $colorNames", backgroundColor: Colors.redAccent);
            }
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Text(
              "Check Answer",
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[800],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
