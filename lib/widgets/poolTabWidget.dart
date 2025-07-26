import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/providers/poolProvider.dart';
import 'package:vocabb/widgets/progressBarWidget.dart';
import 'package:vocabb/widgets/ratingWidget.dart';

import '../pages/poolPage.dart';

class PoolTabWidget extends StatelessWidget {

  final PoolModel poolModel;

  const PoolTabWidget({
    super.key,
    required this.poolModel
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PoolPage(
            poolModel: poolModel
        )));
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
                      Text(poolModel.name, style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )),
                      Text(poolModel.user, style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w300,
                        fontSize: 12
                      ))
                    ],
                  ),
                  RatingWidget(rating: poolModel.rating, size: 13)
                ],
              ),
              SizedBox(height: 18,),
              Consumer<PoolProvider>(
                builder: (context, provider, _) {
                  return Text("${poolModel.masteredWordsCount}/${poolModel.totalWordsCount}", style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w300,
                      fontSize: 11
                  ),);
                }
              ),
              SizedBox(height: 5),
              ProgressBarWidget(
                total: poolModel.totalWordsCount,
                fraction: poolModel.masteredWordsCount
              )
            ],
          ),
        ),
      ),
    );
  }
}


