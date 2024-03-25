import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_app/custom_rect_tween.dart';
import 'package:mobile_app/database/classes/crack_info.dart';
import 'database/classes/image.dart';
import 'database/crack_db.dart';

class DeleteImagePopup extends StatefulWidget {
  final List<int> imageID;
  const DeleteImagePopup({
    super.key,
    required this.imageID
  });

  @override
  State<DeleteImagePopup> createState() => _DeleteImagePopupState();
}

class _DeleteImagePopupState extends State<DeleteImagePopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Delete-image-hero",
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: SizedBox(
              width: 300,
              height: 180,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Delete Image",
                          style: TextStyle(
                            color: Color(0xff284b63),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Are you sure you want to delete this file? It cannot be recovered.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffd9d9d9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () async {
                                // Perform deletion logic here
                                // Example: Delete image from database
                                var crackDB = CrackDB();

                                for(int i = 0; i < widget.imageID.length; i++){
                                  List<CrackInfo> imageInfo = await crackDB.fetchALlCrackIDs(imageID: widget.imageID[i]);
                                  List<ImageDB> imageList = await crackDB.getImageID(imageID: widget.imageID[i]);
                                  await crackDB.deleteImage(id: widget.imageID[i]);
                                  await crackDB.deletePrediction(id: widget.imageID[i]);
                                  await crackDB.deleteCrackInfo(id: widget.imageID[i]);
                                  await crackDB.deleteBuilding(id: imageInfo[0].buildingID);
                                  await crackDB.deleteFloor(id: imageInfo[0].floorID);
                                  await crackDB.deleteRoom(id: imageInfo[0].roomID);
                                  await File(imageList[0].imagePath).delete();
                                }
                                Navigator.pop(context, true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff284b63),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'CONFIRM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
