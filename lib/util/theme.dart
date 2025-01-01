import 'package:flutter/material.dart';
import 'package:my_tube/util/constant.dart';

ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    secondaryHeaderColor: secondColor, // Set your custom secondary color
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondColor, // Use secondary color
        foregroundColor: Colors.white, // Text color
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: secondColor.withOpacity(0.1), // Light secondary background
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondColor.withOpacity(0.8)),
      ),
      labelStyle: TextStyle(color: secondColor),
      hintStyle: TextStyle(color: Colors.grey),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: secondColor, // Custom secondary color for progress indicator
      circularTrackColor: secondColor.withOpacity(0.3),
    ),
  );
}
