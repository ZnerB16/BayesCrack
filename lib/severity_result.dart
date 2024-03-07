import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/main_menu.dart';
import 'package:mobile_app/input_img_details.dart';

class SeverityResultScreen extends StatelessWidget {
  final String imagePath;
  final String classificationResult;

  const SeverityResultScreen({
    required this.imagePath,
    required this.classificationResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crack Severity Classification'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display image
          Expanded(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          // Display classification result
          Text(classificationResult),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xffd9d9d9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xffd9d9d9),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainMenu(),
                      ),
                    );
                  },
                  child: const Text(
                    'DONE',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xff284b63),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xff284b63),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CrackInput(imagePath),
                      ),
                    );
                  },
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
