import 'package:flutter/material.dart';

class RemarksDialog extends StatelessWidget {
  final String? remarks;

  RemarksDialog({this.remarks});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent, // Set the background color to transparent
      content: Container(
        decoration: BoxDecoration(
          color: Color(0xFF284b63), // Background color of the dialog
          borderRadius: BorderRadius.circular(10.0), // Optional: for rounded corners
        ),
        padding: EdgeInsets.all(16.0), // Optional: padding for content
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, // Align content in the center
          children: [
            Text(
              'Image Remarks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              remarks ?? 'No remarks available',
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center, // Align text in the center
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
