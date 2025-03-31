import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/pages/createPoolPage.dart';
import 'package:vocabb/pages/explorePage.dart';
import 'package:vocabb/pages/homePage.dart';
import 'package:vocabb/pages/poolPage.dart';
import 'package:vocabb/widgets/floatingActionButtonWidget.dart';

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

  void _createItemDialog(BuildContext context, Size size) {
    print(context.widget);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: size.height*0.6,
            width: size.width*0.8,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print("create pool");
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePoolPage()));
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Create A Pool", style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)
                              )),
                              SizedBox(height: 8,),
                              Text(
                                "A pool is a collection of words. You can add words to a pool as and when you like. You can learn the words in a pool using our effective learning method",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
        );
      }
    );
  }

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBarWidget(
            leadingIcon: Icons.menu,
            action: () {
              print("Menu");
            }),
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
      floatingActionButton: _selectedPage == 0
        ? FloatingActionButtonWidget(
          onPressed: () {
            _createItemDialog(context, size);
          }
        )
        : const SizedBox.shrink()

    );
  }
}
