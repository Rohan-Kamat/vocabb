import 'package:flutter/material.dart';
import 'package:vocabb/pages/explorePage.dart';
import 'package:vocabb/pages/homePage.dart';
import 'package:vocabb/pages/poolPage.dart';

import '../widgets/appBarWidget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;

  final List<IconData> _activeIcons = <IconData>[
    Icons.home_filled,
    Icons.explore,
    Icons.assignment,
    Icons.person
  ];

  final List<IconData> _inactiveIcons = <IconData>[
    Icons.home_outlined,
    Icons.explore_outlined,
    Icons.assignment_outlined,
    Icons.person_outlined,
  ];

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const ExplorePage()
  ];



  Widget _buildNavBarItem(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPage = index;
        });
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: _selectedPage == index
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.secondary
        ),
        child: Center(
          child: _selectedPage == index
              ? Icon(_activeIcons[index], color: Colors.white)
              : Icon(_inactiveIcons[index], color: Theme.of(context).scaffoldBackgroundColor)
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBarWidget(leadingIcon: Icons.menu,),
      ),
      body: SingleChildScrollView(child: _pages[_selectedPage]),
      bottomNavigationBar: Container(
        height: 75,
        color: Theme.of(context).colorScheme.secondary, // Background color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavBarItem(0),
            _buildNavBarItem(1),
            _buildNavBarItem(2),
            _buildNavBarItem(3),
          ],
        ),
      ),
    );
  }
}
