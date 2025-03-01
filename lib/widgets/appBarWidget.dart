import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final IconData leadingIcon;

  const AppBarWidget({
    super.key,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(leadingIcon, color: Theme.of(context).colorScheme.secondary,), // Drawer icon
          onPressed: () {
            if (leadingIcon == Icons.chevron_left) {
              Navigator.pop(context);
            } else if (leadingIcon == Icons.menu) {
              print("Menu");
            }
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
