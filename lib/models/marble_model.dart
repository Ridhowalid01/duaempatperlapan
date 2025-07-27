import 'package:flutter/material.dart';

class MarbleModel {
  Offset position;
  int? groupId;
  Color color;
  final Color defaultColor;

  MarbleModel({
    required this.position,
    this.groupId,
    this.color = Colors.deepPurple,
  }) : defaultColor = color;
}

