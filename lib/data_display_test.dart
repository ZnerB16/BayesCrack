import 'dart:io';
import 'package:flutter/material.dart';
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
    var image = await crackDB.getLatestImage();
    setState(() {
      path = image[1];
    });
    print(path);
  }


  @override
  Widget build(BuildContext context) {
    getImage();

    return Scaffold(
      body: Column(
        children: [
          Image.file(
            File(path)
          )
        ],
      ),
    );
  }
}
