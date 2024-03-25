import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_app/custom_rect_tween.dart';
import 'package:mobile_app/database/classes/image.dart';
import 'database/classes/crack_info.dart';
import 'database/crack_db.dart';

class DeleteFolderPopup extends StatefulWidget {
  final List<String> trackingNo;
  const DeleteFolderPopup({
    super.key,
    required this.trackingNo
  });

  @override
  State<DeleteFolderPopup> createState() => _DeleteFolderPopupState();
}

class _DeleteFolderPopupState extends State<DeleteFolderPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Delete-folder-hero",
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
                          "Delete Folder",
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
                                // Example: Delete folder from database
                                var crackDB = CrackDB();
                                for(int i = 0; i < widget.trackingNo.length; i++){
                                  List<CrackInfo> trackInfo = await crackDB.fetchALlCrackTracking(trackingNo: int.parse(widget.trackingNo[i].replaceAll(RegExp(r'[^0-9]'),'')));
                                  for(int j = 0; j < trackInfo.length; j++){
                                    List<ImageDB> imageList = await crackDB.getImageOnTrackingNo(trackingNo: trackInfo[j].trackingNo);
                                    await crackDB.deleteImage(id: trackInfo[j].imageID);
                                    await crackDB.deletePrediction(id: trackInfo[j].imageID);
                                    await crackDB.deleteCrackInfo(id: trackInfo[j].imageID);
                                    await crackDB.deleteBuilding(id: trackInfo[j].buildingID);
                                    await crackDB.deleteFloor(id: trackInfo[j].floorID);
                                    await crackDB.deleteRoom(id: trackInfo[j].roomID);
                                    await File(imageList[j].imagePath).delete();
                                  }
                                }

                                Navigator.pop(context);
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