import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/pages/homePage.dart';
import 'package:vocabb/pages/mainPage.dart';
import 'package:vocabb/providers/addWordProvider.dart';
import 'package:vocabb/providers/loadingProvider.dart';
import 'package:vocabb/providers/wordMeaningsProvider.dart';
import 'package:vocabb/theme.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AddWordProvider()),
            ChangeNotifierProvider(create: (context) => LoadingProvider()),
            ChangeNotifierProvider(create: (context) => WordMeaningsProvider())
          ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AddWordProvider addWordProvider = AddWordProvider();

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
