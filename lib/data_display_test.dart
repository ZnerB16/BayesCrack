import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_app/main_menu.dart';
import 'database/classes/image.dart';
import 'database/crack_db.dart';

class DisplayDataFromDB extends StatefulWidget{
  const DisplayDataFromDB({super.key});

  @override
  State<DisplayDataFromDB> createState() => _DisplayDataFromDB();
}

class _DisplayDataFromDB extends State<DisplayDataFromDB>{
  String path = "";

  void getImage() async {
    var crackDB = CrackDB();

    List<ImageDB> imageList;
    setState(() async {
      imageList = await crackDB.getLatestImage();
      path = imageList[0].imagePath;
    });
  }


  @override
  Widget build(BuildContext context) {
    getImage();

    return Scaffold(
      body: Column(
        children: [
          Image.file(
            File(path)
          ),
          SizedBox(
            width: 120,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to the camera screen
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MainMenu()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffd9d9d9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Main Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
