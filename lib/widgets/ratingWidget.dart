import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {

  final int rating;
  final double size;


  const RatingWidget({
    super.key,
    required this.rating,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    // List <Icon>stars = <Icon>[];
    // for (int i = 0; i < 5; i++) {
    //   stars.add(Icon(
    //     Icons.star,
    //     size: size,
    //     color: i < rating
    //       ? Theme.of(context).primaryColor
    //       : Theme.of(context).scaffoldBackgroundColor,
    //   ));
    // }
    return SizedBox(
      height: size,
      width: size*5,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Icon(
              Icons.star,
              color: index < rating
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
              size: size,
          );
        },
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
