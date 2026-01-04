
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/services/dbServices.dart';
import 'package:vocabb/widgets/poolTabWidget.dart';
import 'package:vocabb/widgets/searchBarWidget.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final Stream<QuerySnapshot> _poolStream =
    DbServices.db.collection(DbServices.POOLS_COLLECTION_NAME).snapshots();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height*0.054,),
        Column(
          children: [
            SizedBox(
              width: 250,
              child: Text("All Pools", textAlign: TextAlign.center, style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )),
            ),
            SizedBox(height: size.height*0.04),
            SizedBox(
              width: size.width*(0.8),
              child: SearchBarWidget(),
            ),
            SizedBox(height: 45),
            Container(
                height: (size.height - 75)*0.63,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _poolStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong. Make sure your internet connection is stable and try again", style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                          fontSize: 15
                      ), textAlign: TextAlign.center,);
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary
                          ),
                        ),
                      );
                    }

                    var poolsList = snapshot.data!.docs;
                    return poolsList.isEmpty
                      ? Text("No pools available. Create a pool by clicking on the plus icon on the bottom right corner", style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                        fontSize: 15,
                      ), textAlign: TextAlign.center,)
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return  PoolTabWidget(
                                poolModel:  PoolModel.fromJson(
                                    poolsList[index].id,
                                    poolsList[index].data() as Map<String, dynamic>
                                )
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 12,
                            );
                          },
                          itemCount: poolsList.length
                      );
                  }
                )
            )
          ],
        )
      ],
    );
  }
}
