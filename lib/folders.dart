import 'package:flutter/material.dart';
import 'folder_view.dart';

class Folders extends StatelessWidget {
  final String child;

  Folders({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FolderView(),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Container(
              height: 50,
              child: Row(
                children: [
                  SizedBox(width: 5),
                  Image.asset(
                    'assets/images/folder.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 10),
                  Center(
                    child: Text(
                      child,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}