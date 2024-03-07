import 'package:flutter/material.dart';
import 'package:mobile_app/input_img_details.dart';
import 'main_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crack Identification Classifier',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff284b63)),
        useMaterial3: true,
      ),
      home: const MainMenu(),
    );
  }
}

