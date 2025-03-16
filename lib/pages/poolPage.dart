import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/pages/addWordPage.dart';
import 'package:vocabb/providers/addWordProvider.dart';
import 'package:vocabb/services/apiServices.dart';
import 'package:vocabb/widgets/appBarWidget.dart';
import 'package:vocabb/widgets/newWordWidget.dart';
import 'package:vocabb/widgets/poolNameWidget.dart';
import 'package:vocabb/widgets/ratingWidget.dart';
import 'package:vocabb/widgets/wordListWidget.dart';

import '../consts/consts.dart';

class PoolPage extends StatelessWidget {

  final String title;
  final String userName;
  final int rating;

  final TextEditingController _newWordController = TextEditingController();

  final Dio dio = Dio();

  PoolPage({
    super.key,
    required this.title,
    required this.userName,
    required this.rating
  });


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AddWordProvider addWordProvider = Provider.of<AddWordProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBarWidget(
          leadingIcon: Icons.chevron_left,
          action: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28),
            Container(
              color: Theme.of(context).colorScheme.secondary,
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PoolNameWidget(poolName: title),
                      IconButton(
                          onPressed: () {
                            print("Pool settings pressed");
                          },
                          icon: Icon(Icons.settings, color: Theme.of(context).scaffoldBackgroundColor)
                      )
                    ],
                  ),
                  SizedBox(height: 4,),
                  Text(userName, style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 16
                  )),
                  SizedBox(height: 8),
                  RatingWidget(rating: rating, size: 16),
                  SizedBox(height: 57),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      SizedBox(
                        height: 38,
                        width: 176,
                        child: OutlinedButton(
                            onPressed: () {
                              print("Learn pool");
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: Text("Learn Pool")
                        ),
                      ),
                      SizedBox(
                        height: 38,
                        width: 176,
                        child: OutlinedButton(
                            onPressed: () {
                              print("Learn pool");
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              foregroundColor: Theme.of(context).colorScheme.secondary,
                            ),
                            child: const Text("Rate Pool")
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Words", style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),
                  Consts.poolWords1.isEmpty
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                            "Add a word to this pool by clicking on the plus icon on the bottom right corner of the screen",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center
                        ),
                      ),
                    )
                    : WordListWidget(words: Consts.poolWords1)
                ],
              )
            )
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddWordPage()));
        },
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
        ),
        child: const Icon(Icons.add),
      )
    );
  }
}
