import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFEEEEEE),
      primaryColor: const Color(0xFF7BC74D),
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary: const Color(0xFF222831),
        brightness:  Brightness.light,
      ),
      cardColor: Colors.white,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF7BC74D),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      radioTheme: RadioThemeData(fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            // If the radio button is selected
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF7BC74D); 
            }
            return const Color(0xFF222831);
          })
      ),
      fontFamily: 'Fira Sans',
      textTheme: const TextTheme(
        displayMedium: TextStyle(
          color: Color(0xFF222831),
          fontFamily: 'Fira Sans',
          fontSize: 25
        )
      )
    );
  }
}