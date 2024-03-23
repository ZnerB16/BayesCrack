import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/database/classes/crack_info.dart';
import 'package:mobile_app/database/crack_db.dart';
import 'dart:io';
import 'database/classes/prediction.dart';
import 'remarks.dart'; // Importing RemarksDialog class

class ImageInterface extends StatefulWidget {
  final String img_path;
  final String img_id;
  final DateTime capture_date;

  const ImageInterface({super.key, 
    required this.img_path,
    required this.img_id,
    required this.capture_date,
  });

  @override
  State<ImageInterface> createState() => _ImageInterfaceState();
}

class _ImageInterfaceState extends State<ImageInterface> {
  String? geolocation;
  int? trackingNo;
  String? building;
  String? floor;
  String? room;
  String? severity;
  String? recommend;
  String? remarks;

  void getInfo() async{
    var crackDB = CrackDB();
    List<CrackInfo> crackList = await crackDB.fetchALlCrack(imageID: int.parse(widget.img_id));
    List<Prediction> predictionList = await crackDB.getPrediction(imageID: int.parse(widget.img_id));

    setState(() {
      trackingNo = crackList[0].trackingNo;
      geolocation = crackList[0].geolocation;
      building  = crackList[0].building;
      floor = crackList[0].floor;
      room = crackList[0].room;
      severity = predictionList[0].prediction;
      recommend = predictionList[0].recommend;
      remarks = crackList[0].remarks;
    });
  }

  @override
  void initState(){
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(widget.capture_date);
    final formattedTime = DateFormat.jm().format(widget.capture_date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crack Severity Classification'),
        automaticallyImplyLeading: true, // To show back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and details row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image on the left
                SizedBox(
                  width: 180, // Fixed width for image
                  child: Stack(
                    children: [
                      Image.file(
                        File(widget.img_path),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                          height: 40, // Adjust the height as needed
                          child: IconButton(
                            icon: Image.asset('assets/images/question_mark.png'), // Add your icon asset
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RemarksDialog(remarks: remarks);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // Space between image and details
                // Details on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Image Name: Crack_${widget.img_id ?? ''}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Capture Date: $formattedDate',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Capture Time: $formattedTime',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Geolocation: ${geolocation ?? ''}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tracking Number: ${trackingNo ?? ''}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Building: ${building ?? ''}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Floor: ${floor ?? ''}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Room: ${room ?? ''}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Space between details and severity/recommendation
            // Box containing severity and recommendation
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Severity row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Severity: ${severity ?? ''}',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // Space between severity and recommendation
                  // Recommendation row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child:  Text(
                          recommend?? '',
                          style: const TextStyle(
                              fontSize: 18,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
