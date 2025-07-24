import 'package:flutter/material.dart';

class MurblesAreaWidget extends StatelessWidget {
  const MurblesAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        children: List.generate(
          24,
          (index) => Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
