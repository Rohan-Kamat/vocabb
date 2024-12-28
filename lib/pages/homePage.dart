import 'package:flutter/material.dart';
import 'package:vocabb/widgets/appBarWidget.dart';

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
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: AppBarWidget(),
        ),
        body: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              child: Column(
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
                  SizedBox(height: 50),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(child: Text("Recents Page")),
                        Center(child: Text("Tests Page")),
                        Center(child: Text("Pools Page")),
                      ],
                    )
                  )

                ],
              ),
            )
          ],
        )
    );
  }
}
