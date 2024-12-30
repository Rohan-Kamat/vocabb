import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {

  int rating;

  RatingWidget({
    super.key,
    required this.rating
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 68,
      height: 11,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Icon(
              Icons.star,
              color: index < rating
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
              size: 13,
          );
        },
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
