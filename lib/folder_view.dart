import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'gallery.dart';

class FolderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ImageList(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  List<Map<String, dynamic>> imageData = [
    {
      'img_path': 'assets/images/brenz.png',
      'img_id': 'Image 1',
      'capture_date': '2024-03-14 05:38:03',
    },
    {
      'img_path': 'assets/images/raven.png',
      'img_id': 'Image 2',
      'capture_date': '2024-03-15 11:00:00',
    },
    {
      'img_path': 'assets/images/francis.png',
      'img_id': 'Image 3',
      'capture_date': '2024-03-15 12:00:00'
    },
  ];

  List<bool> isCheckedList = List.generate(3, (index) => false); // Generate initial list of checkbox states
  List<int> selectedIndices = []; // Maintain a list of selected indices

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: imageData.length,
            itemBuilder: (context, index) {
              final img_path = imageData[index]['img_path'];
              final img_id = imageData[index]['img_id'];
              final capture_date = DateTime.parse(imageData[index]['capture_date']);
              final formattedDate = DateFormat.yMMMd().format(capture_date);
              final formattedTime = DateFormat.jm().format(capture_date);

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: isCheckedList[index], // Use isCheckedList to maintain the state
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedList[index] = value ?? false; // Update isCheckedList state
                                if (isCheckedList[index]) {
                                  selectedIndices.add(index); // Add index to selectedIndices when checked
                                } else {
                                  selectedIndices.remove(index); // Remove index from selectedIndices when unchecked
                                }
                              });
                            },
                          ),
                          Image.asset(
                            img_path,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                      title: Text(img_id),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: $formattedDate'),
                          Text('Time: $formattedTime'),
                        ],
                      ),
                      onTap: () {
                        // Handle tap on list item
                      },
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey),
                ],
              );
            },
          ),
        ),
        if (selectedIndices.isNotEmpty) // Show delete button only if any checkboxes are checked
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 70, // Set width to desired size
              height: 70, // Set height to desired size
              child: IconButton(
                onPressed: () {
                  // Perform delete operation for selected indices
                  setState(() {
                    // Remove items from imageData using selectedIndices
                    selectedIndices.sort((a, b) => b.compareTo(a)); // Sort indices in descending order
                    for (int index in selectedIndices) {
                      imageData.removeAt(index);
                    }
                    // Clear selectedIndices and isCheckedList after deletion
                    selectedIndices.clear();
                    isCheckedList = List.generate(imageData.length, (index) => false);
                  });
                },
                icon: Image.asset('assets/images/delete2.png'), // Use delete.png asset
              ),
            ),
          ),
      ],
    );
  }
}
