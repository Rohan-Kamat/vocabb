import 'package:flutter/material.dart';
import 'package:vocabb/widgets/progressBarWidget.dart';

class LearningProgressWidget extends StatelessWidget {

  final String title;
  final int fraction;
  final int total;
  final Color? color;

  const LearningProgressWidget({
    super.key,
    required this.title,
    required this.fraction,
    required this.total,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 15,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "$title : ",
                style: const TextStyle(
                  fontWeight: FontWeight.w500
                )
              ),
              TextSpan(text: "$fraction/$total")
            ]
          )
        ),
        ProgressBarWidget(
          total: total,
          fraction: fraction,
          backgroundColor: Colors.white,
          foregroundColor: color,
        )
      ],
    );
  }
}
