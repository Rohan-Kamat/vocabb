import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // Height of the search bar
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary, // Background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: TextField(
        style: const TextStyle(
          color: Color(0xFFEEEEEE), // Text color
        ),
        cursorColor: const Color(0xFFEEEEEE), // Cursor color
        decoration: InputDecoration(
          hintText: "search",
          hintStyle: TextStyle(
            color: const Color(0xFFEEEEEE).withOpacity(0.7), // Hint text color
          ),
          border: InputBorder.none, // No default border
          contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.search, // Search action button
              color: Color(0xFFEEEEEE),
            ),
            onPressed: () {
              print("Search button pressed");
            },
          ),
        ),
      ),
    );
  }
}
