import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/database/classes/image.dart';
import 'package:mobile_app/database/crack_db.dart';
import 'main_menu.dart';
import 'delete_image_popup.dart';
import 'image_interface.dart'; // Import ImageInterface

class FolderView extends StatelessWidget {
    final String folderName;
    final int trackingNo;
    FolderView({
        required this.folderName,
        required this.trackingNo
    });
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(folderName), // Use folderName as the title
            ),
            body: ImageList(trackingNo: trackingNo),
            bottomNavigationBar: CustomBottomNavigationBar(),
        );
    }
}

class ImageList extends StatefulWidget {
    final int trackingNo;
    ImageList({
        super.key,
        required this.trackingNo
    });

    @override
    _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
    List<Map<String, dynamic>> imageData = [];
    List<ImageDB> imageList = [];
    List<bool> isCheckedList = [];

    var crackDB = CrackDB();
    void getImages() async {

        imageList = await crackDB.getImageOnTrackingNo(trackingNo: widget.trackingNo);

        setState(() {
          for(int i = 0; i < imageList.length; i++){
              imageData.add({
                  'img_path': imageList[i].imagePath,
                  'img_name': 'Image ${imageList[i].id}',
                  'capture_date': imageList[i].dateTime
              });
              print("Added $i");
          }
        });
    }

    @override
    void initState() {
        super.initState();
        imageData = [];
        getImages();
        print(widget.trackingNo);
        isCheckedList = List.generate(imageData.length, (index) => false); // Dynamic generate list for checkboxes
    }

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
                            final img_name = imageData[index]['img_name'];
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
                                                        activeColor: Colors.black, // Set the color of the checkmark to black
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
                                            title: Text(img_name),
                                            subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Text('Date: $formattedDate'),
                                                    Text('Time: $formattedTime'),
                                                ],
                                            ),
                                            onTap: () {
                                                // Navigate to ImageInterface screen when tapped
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ImageInterface(
                                                        img_path: img_path,
                                                        img_id: img_name,
                                                        capture_date: capture_date,
                                                        // Pass other required parameters here
                                                    )),
                                                );
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
                                    // Show delete image popup
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                            return DeleteImagePopup();
                                        },
                                    );
                                },
                                icon: Image.asset('assets/images/delete2.png'), // Use delete.png asset
                            ),
                        ),
                    ),
            ],
        );
    }
}
