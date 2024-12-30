import 'package:flutter/material.dart';
import 'package:vocabb/widgets/ratingWidget.dart';

class PoolTabWidget extends StatelessWidget {

  final String title;
  final String userName;
  final int rating;
  final int totalWords;
  final int masteredWords;

  const PoolTabWidget({
    super.key,
    required this.title,
    required this.userName,
    required this.rating,
    required this.totalWords,
    required this.masteredWords
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        elevation: 4,
        child: Container(
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
                    children: [
                      Text(title, style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )),
                      Text(userName, style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w300,
                        fontSize: 11
                      ))
                    ],
                  ),
                  RatingWidget(rating: rating)
                ],
              ),
              SizedBox(height: 13,),
              Text("${masteredWords}/${totalWords}", style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w300,
                fontSize: 11
              ),),
              SizedBox(height: 5),
              Container(
                height: 14,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                child: FractionallySizedBox(
                  heightFactor: 1,
                  widthFactor: masteredWords/totalWords,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(7),
                          bottomLeft: const Radius.circular(7),
                          topRight: totalWords == masteredWords
                              ? const Radius.circular(7)
                              : Radius.zero,
                          bottomRight: totalWords == masteredWords
                              ? const Radius.circular(7)
                              : Radius.zero
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


