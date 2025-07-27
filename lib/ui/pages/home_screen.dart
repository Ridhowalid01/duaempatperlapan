import 'package:duaempatperlapan/ui/widgets/check_answer_button.dart';
import 'package:duaempatperlapan/ui/widgets/question_box_widget.dart';
import 'package:duaempatperlapan/ui/widgets/question_desc_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/drag_and_drop_area_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          child: const Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuestionDescWidget(),
              QuestionBoxWidget(),
              SizedBox(height: 10),
              DragAndDropAreaWidget(),
              CheckAnswerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
