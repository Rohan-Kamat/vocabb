import 'package:flutter/material.dart';
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
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Color(0xFF7BC74D)), // Custom underline
                  insets: EdgeInsets.symmetric(horizontal: 25.0), // Adjust horizontal padding for compactness
                ),
                indicatorPadding: const EdgeInsets.only(bottom: 8),// Green underline when selected
                labelColor: const Color(0xFF7BC74D),     // Color for selected tab text
                unselectedLabelColor: const Color(0xFF222831), // Color for unselected tab text
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
                    ListView.separated(
                        itemBuilder: (context, index) {
                          return index & 1 == 1
                              ? const TestTabWidget(
                              title: "Test abc",
                              userName: "xyz",
                              rating: 4,
                              isAttempted: true,
                              timeTakenInMinutes: 67,
                              totalTimeInMinutes: 90,
                              score: 30,
                              totalQuestions: 50)
                              : const PoolTabWidget(
                              title: "Name",
                              userName: "username",
                              rating: 3,
                              totalWords: 50,
                              masteredWords: 20
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: 5),
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
                          return const PoolTabWidget(
                              title: "Name",
                              userName: "username",
                              rating: 3,
                              totalWords: 50,
                              masteredWords: 40
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
