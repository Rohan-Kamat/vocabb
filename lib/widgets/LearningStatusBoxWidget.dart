import 'package:flutter/material.dart';
import 'package:vocabb/consts/consts.dart';
import 'package:vocabb/consts/enums.dart';

class LearningStatusBoxWidget extends StatelessWidget {

  final LearningStatus learningStatus;

  const LearningStatusBoxWidget({
    super.key,
    required this.learningStatus
  });

  @override
  Widget build(BuildContext context) {
    Color boxColor;
    Color textColor;
    switch(learningStatus) {
      case LearningStatus.unknown:
        boxColor = Theme.of(context).scaffoldBackgroundColor;
        textColor = Theme.of(context).colorScheme.tertiary;
        break;
      case LearningStatus.learning:
        boxColor = Consts.fadedRed;
        textColor = Consts.red;
        break;
      case LearningStatus.reviewing:
        boxColor = Consts.fadedYellow;
        textColor = Consts.yellow;
        break;
      case LearningStatus.mastered:
        boxColor = Consts.fadedGreen;
        textColor = Consts.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Text(learningStatus.displayText, style: TextStyle(
        color: textColor,
        fontSize: 10
      )),
    );
  }
}
