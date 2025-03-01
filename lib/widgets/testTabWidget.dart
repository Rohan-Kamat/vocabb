import 'package:flutter/material.dart';
import 'package:vocabb/pages/poolPage.dart';
import 'package:vocabb/widgets/ratingWidget.dart';

class TestTabWidget extends StatelessWidget {

  final String title;
  final String userName;
  final int rating;
  final bool isAttempted;
  final int totalQuestions;
  final int score;
  final int totalTimeInMinutes;
  final int timeTakenInMinutes;

  const TestTabWidget({
    super.key,
    required this.title,
    required this.userName,
    required this.rating,
    required this.isAttempted,
    required this.timeTakenInMinutes,
    required this.totalTimeInMinutes,
    required this.score,
    required this.totalQuestions
  });

  @override
  Widget build(BuildContext context) {
    String timeTaken = "";
    if (timeTakenInMinutes ~/ 60 > 0) {
      timeTaken += "${timeTakenInMinutes~/60}hr ";
    }
    if (timeTakenInMinutes%60 > 0) {
      timeTaken += "${timeTakenInMinutes%60}min";
    }
    if (timeTaken == "") {
      timeTaken = "0min";
    }

    String totalTime = "";
    if (totalTimeInMinutes ~/ 60 > 0) {
      totalTime += "${totalTimeInMinutes~/60}hr ";
    }
    if (totalTimeInMinutes%60 > 0) {
      totalTime += "${totalTimeInMinutes%60}min";
    }
    if (totalTime == "") {
      totalTime = "0min";
    }

    return InkWell(
      onTap: () {
        print("Test Tab pressed");
      },
      splashColor: Theme.of(context).scaffoldBackgroundColor,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        elevation: 4,
        child: Container(
          height: 136,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )),
                      Text(userName, style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w300,
                          fontSize: 12
                      ))
                    ],
                  ),
                  RatingWidget(rating: rating, size: 13,)
                ],
              ),
              SizedBox(height: 18,),
              isAttempted
               ? RichText(text: TextSpan(
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Score: ",
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    TextSpan(text: "$score/$totalQuestions", style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ))
                  ]
              ))
              : Text("Not Attempted", style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300
                ),
              ),
              const SizedBox(height: 5),
              isAttempted
                ?  RichText(text: TextSpan(
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Time Taken: ",
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    TextSpan(text: timeTaken, style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ))
                  ]
              ))
              : RichText(text: TextSpan(
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Total Time: ",
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    TextSpan(text: totalTime, style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ))
                  ]
              ))
            ],
          ),
        ),
      ),
    );
  }
}
