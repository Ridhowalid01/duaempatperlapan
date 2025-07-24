import 'package:flutter/material.dart';

class CheckAnswerButton extends StatelessWidget {
  const CheckAnswerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
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
    );
  }
}
