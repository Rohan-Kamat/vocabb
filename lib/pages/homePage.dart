
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/services/dbServices.dart';
import 'package:vocabb/widgets/poolTabWidget.dart';
import 'package:vocabb/widgets/searchBarWidget.dart';
import 'package:vocabb/widgets/testTabWidget.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Stream<QuerySnapshot> _poolStream =
    DbServices.db.collection(DbServices.POOLS_COLLECTION_NAME).snapshots();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              child: TabBar(
                controller: _tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Theme.of(context).primaryColor), // Custom underline
                  insets: const EdgeInsets.symmetric(horizontal: 25.0), // Adjust horizontal padding for compactness
                ),
                indicatorPadding: const EdgeInsets.only(bottom: 8),// Green underline when selected
                labelColor: Theme.of(context).primaryColor,     // Color for selected tab text
                unselectedLabelColor: Theme.of(context).colorScheme.secondary, // Color for unselected tab text
                tabs: const [
                  Tab(text: 'Recents'),
                  Tab(text: 'Tests'),
                  Tab(text: 'Pools'),
                ],
                isScrollable: false, // Prevent tabs from scrolling
              ),
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
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    StreamBuilder<QuerySnapshot>(
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
                        } else if (snapshot.data == null) {
                          return Text("Something went wrong. Make sure your internet connection is stable and try again", style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                              fontSize: 15
                          ), textAlign: TextAlign.center,);
                        }
                        var poolsList = snapshot.data!.docs;
                        print(poolsList);
                        return poolsList.isEmpty
                          ? Text("No pools available. Create a pool by clicking on the plus icon on the bottom right corner", style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                            fontSize: 15,
                          ), textAlign: TextAlign.center,)
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                return  PoolTabWidget(
                                    id: poolsList[index].id,
                                    poolModel:  PoolModel.fromJson(
                                        poolsList[index].data() as Map<String, dynamic>)
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
                    ),
                    ListView.separated(
                        itemBuilder: (context, index) {
                          return const TestTabWidget(
                              title: "Test abc",
                              userName: "xyz",
                              rating: 4,
                              isAttempted: false,
                              timeTakenInMinutes: 75,
                              totalTimeInMinutes: 90,
                              score: 30,
                              totalQuestions: 50);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: 5),
                    ListView.separated(
                        itemBuilder: (context, index) {
                          return  PoolTabWidget(
                            id: "DefaultId",
                            poolModel: PoolModel(
                                name: "Name",
                                user: "Default",
                                rating: 3,
                                words: [],
                                totalWordsCount: 50,
                                masteredWordsCount: 30,
                                learningWordsCount: 2,
                                reviewingWordsCount: 15,
                                unvisitedWordsCount: 3
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: 5)
                  ],
                )
            )
          ],
        )
      ],
    );
  }
}
