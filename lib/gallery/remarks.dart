import 'package:flutter/material.dart';

class RemarksDialog extends StatelessWidget {
  final String? remarks;

  const RemarksDialog({super.key, this.remarks});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent, // Set the background color to transparent
      content: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF284b63), // Background color of the dialog
          borderRadius: BorderRadius.circular(10.0), // Optional: for rounded corners
        ),
        padding: const EdgeInsets.all(16.0), // Optional: padding for content
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, // Align content in the center
          children: [
            const Text(
              'Image Remarks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              remarks ?? 'No remarks available',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center, // Align text in the center
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
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
