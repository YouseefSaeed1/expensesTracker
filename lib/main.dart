import 'package:flutter/material.dart';
import 'package:second_app/screens/expenses_screen.dart';

var kColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kDarkSchema = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
var white = ColorScheme.fromSeed(seedColor: Colors.white);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkSchema,
        cardTheme: const CardTheme().copyWith(
          color: kDarkSchema.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkSchema.primaryContainer,
              foregroundColor: kDarkSchema.onPrimaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorSchema,
        appBarTheme: AppBarTheme(
            backgroundColor: kColorSchema.onPrimaryContainer,
            foregroundColor: kColorSchema.onPrimary),
        cardTheme: const CardTheme().copyWith(
          color: kColorSchema.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchema.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kColorSchema.onSecondaryContainer),
            ),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const ExpensesScreen(),
    );
  }
}
