import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/main_menu.dart';
import 'package:mobile_app/input_img_details.dart';

class SeverityResultScreen extends StatelessWidget {
  final String imagePath;
  final String classificationResult;
  final String formattedDateTime;
  final String geolocation;
  final double latitude;
  final double longitude;

  const SeverityResultScreen({super.key,
    required this.imagePath,
    required this.classificationResult,
    required this.formattedDateTime,
    required this.geolocation,
    required this.latitude,
    required this.longitude
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crack Severity Classification'),
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
                  child: Image.file(File(imagePath)),
                ),
                SizedBox(height: 10),
                Text(
                  'Result: $classificationResult',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Place holder hehehehehhe will assign string soon.'
                  'Oh, a simple complication. Miscommunications lead to fall out. So many things that I wish you knew.'
                  ' So many walls up I cant break through',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CrackInput(
                            imagePath: imagePath,
                            formattedDateTime: formattedDateTime,
                            latitude: latitude,
                            longitude: longitude,
                          ),
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