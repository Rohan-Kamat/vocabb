import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final IconData leadingIcon;
  final VoidCallback action;

  const AppBarWidget({
    super.key,
    required this.leadingIcon,
    required this.action
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(leadingIcon, color: Theme.of(context).colorScheme.secondary,), // Drawer icon
          onPressed: action
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
