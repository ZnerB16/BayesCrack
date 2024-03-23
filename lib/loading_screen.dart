import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image widget
            Image.asset(
              'assets/images/tobedeleted.gif', 
              width: 300, 
              height: 300,
            ),
            const SizedBox(height: 20), 
            // Text widget
            const Text(
              'Loading. Please wait.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff284b63),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}