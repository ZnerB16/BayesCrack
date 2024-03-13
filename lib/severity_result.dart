import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/database/crack_db.dart';
import 'package:mobile_app/main_menu.dart';
import 'package:mobile_app/input_img_details.dart';
import 'severity_result_explanations.dart';
import 'globals.dart';
import 'globals.dart' as globals;

class SeverityResultScreen extends StatelessWidget {
  const SeverityResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    String interpretation = interpretations[globals.classificationResult] ?? 'Explanation not found';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crack Severity Classification',
          style: TextStyle(
              color: Color(0xff284b63),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff284b63), width: 2.0),
                  ),
                  constraints: BoxConstraints(maxHeight: 450),
                  child: Image.file(File(globals.imagePath)),
                ),
                SizedBox(height: 1),
                Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      'Result: $classificationResult',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      interpretation,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xffd9d9d9),
                    borderRadius: BorderRadius.circular(20),
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
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xff284b63),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      var crackDB = CrackDB();
                      // Insert to table
                      crackDB.insertImage(
                          imagePath: globals.imagePath,
                          datetime: globals.formattedDateTime,
                          geolocation: globals.geolocation
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CrackInput(),
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
          ),
        ],
      ),
    );
  }
}