import 'package:flutter/material.dart';
import 'package:project_mobile/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homepage',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF7CC9E5),
          secondary: const Color(0xFFFFFDF5),
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 210, 80),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 27, 70, 93)
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7CC9E5),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7CC9E5),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: Homepage(),
    );
  }
}
