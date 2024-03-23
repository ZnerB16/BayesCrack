import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/database/classes/image.dart';
import 'package:mobile_app/database/crack_db.dart';
import 'main_menu.dart';
import 'dart:io';
import 'delete_image_popup.dart';
import 'image_interface.dart'; // Import ImageInterface

class FolderView extends StatelessWidget {
    final String folderName;
    final int trackingNo;
    const FolderView({super.key, 
        required this.folderName,
        required this.trackingNo
    });
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                    Navigator.pop(context);
                },
                child: Row(
                  children: [
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xff284b63),
                        BlendMode.modulate,
                      ),
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: Image.asset('assets/images/back_icon.png'),
                      ),
                    ),
                    const Text(
                      'Back',
                      style: TextStyle(
                        color: Color(0xff284b63),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
                centerTitle: true,
                title: Text(folderName,
                    style: TextStyle(color: Color(0xff284b63)
                    ),
                  ), 
            ),
            body: ImageList(trackingNo: trackingNo),
            bottomNavigationBar: const CustomBottomNavigationBar(),
        );
    }
}

class ImageList extends StatefulWidget {
    final int trackingNo;
    const ImageList({
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
    Future<void> getImages() async {

        imageList = await crackDB.getImageOnTrackingNo(trackingNo: widget.trackingNo);
        setState(() {
          for(int i = 0; i < imageList.length; i++){
              imageData.add({
                  'img_path': imageList[i].imagePath,
                  'img_id': '${imageList[i].id}',
                  'capture_date': imageList[i].dateTime
              });
          }
        });
    }

    @override
    void initState() {
        super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) async {
            imageData = []; // To avoid duplicate images when page refreshed
            await getImages(); // Inserts image data in imageData map
            isCheckedList = List.generate(imageData.length, (index) => false); // Dynamic generate list for checkboxes
        });
    }

    List<int> selectedIndices = []; // Maintain a list of selected indices
    @override
    Widget build(BuildContext context) {
        print("Records in list: ${imageData.length}");
        return Column(
            children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: imageData.length,
                        itemBuilder: (context, index) {
                            final imgPath = imageData[index]['img_path'];
                            final imgID = imageData[index]['img_id'];
                            final captureDate = DateTime.parse(imageData[index]['capture_date']);
                            final formattedDate = DateFormat.yMMMd().format(captureDate);
                            final formattedTime = DateFormat.jm().format(captureDate);
                            return Column(
                                children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                                    Image.file(
                                                        File(imgPath),
                                                        fit: BoxFit.cover,
                                                        width: 60,
                                                        height: 60,
                                                    ),
                                                ],
                                            ),
                                            title: Text('Crack_$imgID'),
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
                                                        img_path: imgPath,
                                                        img_id: imgID,
                                                        capture_date: captureDate,
                                                        // Pass other required parameters here
                                                    )),
                                                );
                                            },
                                        ),
                                    ),
                                    const Divider(height: 1, color: Colors.grey),
                                ],
                            );
                        },
                    ),
                ),
                if (selectedIndices.isNotEmpty) // Show delete button only if any checkboxes are checked
                    Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            width: 70, // Set width to desired size
                            height: 70, // Set height to desired size
                            child: IconButton(
                                onPressed: () {
                                    // Show delete image popup
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                            return const DeleteImagePopup();
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
