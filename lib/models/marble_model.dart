import 'package:flutter/material.dart';

class MarbleModel {
  Offset position;
  int? groupId;
  Color color;

  MarbleModel({
    required this.position,
    this.groupId,
    this.color = Colors.deepPurple,
  });

  Color get defaultColor => Colors.deepPurple;
}


