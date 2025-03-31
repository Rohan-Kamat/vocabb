import 'package:flutter/material.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/widgets/poolTabWidget.dart';
import 'package:vocabb/widgets/searchBarWidget.dart';
import 'package:vocabb/widgets/testTabWidget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> filters = [
    "User",
    "Date"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                  insets: EdgeInsets.symmetric(horizontal: 30.0), // Adjust horizontal padding for compactness
                ),
                indicatorPadding: const EdgeInsets.only(bottom: 8),// Green underline when selected
                labelColor: const Color(0xFF7BC74D),     // Color for selected tab text
                unselectedLabelColor: const Color(0xFF222831), // Color for unselected tab text
                tabs: const [
                  Tab(text: 'Tests'),
                  Tab(text: 'Pools'),
                ],
                isScrollable: false, // Prevent tabs from scrolling
              ),
            ),
            SizedBox(height: size.height*0.04),
            SizedBox(
              width: size.width*(0.8),
              child: const SearchBarWidget(),
            ),
            const SizedBox(height: 25,),
            Container(
              width: size.width*0.8,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 0.2,
                  color: Theme.of(context).colorScheme.tertiary
                )
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Filter By", style: TextStyle(fontSize: 16),),
                      SizedBox(width: 8,),
                      DropdownMenu(
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: "User", label: "User"),
                          DropdownMenuEntry(value: "Date", label: "Date")
                        ],
                        inputDecorationTheme: InputDecorationTheme(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                          border: InputBorder.none,
                          constraints: BoxConstraints(
                            maxHeight: 35,
                          ),
                          iconColor: Theme.of(context).scaffoldBackgroundColor
                        ),
                        width: size.width*0.56,
                      )
                    ],
                  )
                ],
              ),
              
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
                          return PoolTabWidget(
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
