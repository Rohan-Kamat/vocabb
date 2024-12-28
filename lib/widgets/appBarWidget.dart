import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.secondary,), // Drawer icon
          onPressed: () {
            print(5);
          },
        ),
      ),
      leadingWidth: 28.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0), // Add top padding
        child: Text("vocabb", style: Theme.of(context).textTheme.displayMedium),
      ),
    );
  }
}
