import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'remarks.dart'; // Importing RemarksDialog class

class ImageInterface extends StatelessWidget {
  final String img_path;
  final String img_id;
  final DateTime capture_date;
  final String? geolocation;
  final int? tracking_no;
  final int? building_id;
  final int? floor_id;
  final int? room_id;
  final String? severity;
  final String? recommendation;
  final String? remarks; // Add remarks parameter

  ImageInterface({
    required this.img_path,
    required this.img_id,
    required this.capture_date,
    this.geolocation,
    this.tracking_no,
    this.building_id,
    this.floor_id,
    this.room_id,
    this.severity,
    this.recommendation,
    this.remarks, // Initialize remarks parameter
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(capture_date);
    final formattedTime = DateFormat.jm().format(capture_date);

    return Scaffold(
      appBar: AppBar(
        title: Text('Crack Severity Classification'),
        automaticallyImplyLeading: true, // To show back button
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                      Image.asset(
                        img_path,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
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
                SizedBox(width: 16), // Space between image and details
                // Details on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Image Name: ${img_id ?? ''}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Capture Date: $formattedDate',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Capture Time: $formattedTime',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Geolocation: ${geolocation ?? ''}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tracking Number: ${tracking_no ?? ''}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Building: ${building_id ?? ''}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Floor: ${floor_id ?? ''}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Room: ${room_id ?? ''}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // Space between details and severity/recommendation
            // Box containing severity and recommendation
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Severity row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Severity: ${severity ?? ''}',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8), // Space between severity and recommendation
                  // Recommendation row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Recommendation here ${recommendation ?? ''}',
                        style: TextStyle(fontSize: 18),
                      ),
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
