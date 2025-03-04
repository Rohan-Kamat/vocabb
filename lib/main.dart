import 'package:flutter/material.dart';
import 'package:vocabb/pages/homePage.dart';
import 'package:vocabb/pages/mainPage.dart';
import 'package:vocabb/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Vocabb',
        debugShowCheckedModeBanner: false,
        theme: Styles.themeData(context),
        home: const MainPage()
      ),
    );
  }
}
