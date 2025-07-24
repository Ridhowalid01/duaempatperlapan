import 'package:flutter/material.dart';

class CardOnEdgeWidget extends StatelessWidget {
  const CardOnEdgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColorCard(Colors.orangeAccent, Colors.orange),
        _buildColorCard(Colors.yellowAccent, Colors.yellow),
        _buildColorCard(Colors.cyanAccent, Colors.cyan),
      ],
    );
  }
}

Widget _buildColorCard(Color mainColor, Color shadowColor) {
  return Container(
    width: 50,
    height: 100,
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