import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:vocabb/pages/mainPage.dart';
import 'package:vocabb/providers/addWordProvider.dart';
import 'package:vocabb/providers/loadingProvider.dart';
import 'package:vocabb/providers/wordMeaningsProvider.dart';
import 'package:vocabb/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
