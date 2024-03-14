import 'package:flutter/material.dart';
import 'delete_image_popup.dart';
import 'folder_view.dart';
import 'package:flutter/material.dart';
import 'folder_view.dart'; 
import 'gallery.dart';

class FoldersStateful extends StatefulWidget {
  final String child;
  final String folderName; 
  final bool isChecked;
  final ValueChanged<bool> onCheckboxChanged;

  FoldersStateful({
    required this.child,
    required this.folderName,
    required this.isChecked,
    required this.onCheckboxChanged,
  });

  @override
  _FoldersStatefulState createState() => _FoldersStatefulState();
}

class _FoldersStatefulState extends State<FoldersStateful> {
  bool _isChecked = false; // Local state to track checkbox state

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked; // Initialize checkbox state from the provided value
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another view or screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FolderView(folderName: widget.folderName),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  value: _isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      _isChecked = newValue ?? false; // Update local state
                      widget.onCheckboxChanged(_isChecked); // Call callback
                    });
                  },
                ),
                SizedBox(width: 10),
                Image.asset(
                  'assets/images/folder.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.child,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
