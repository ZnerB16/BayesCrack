import 'dart:io';
import 'package:flutter/material.dart';
import 'custom_rect_tween.dart';
import 'package:mobile_app/database/classes/image.dart';
import '../database/classes/crack_info.dart';
import '../database/crack_db.dart';

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
  bool _showConfirmationInput = false;
  late TextEditingController _confirmationController;
  bool _wrongConfirmation = false;

  @override
  void initState() {
    super.initState();
    _confirmationController = TextEditingController();
  }

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
              height: 200,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Color(0xff284b63),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Show confirmation after click
                      if (!_showConfirmationInput)
                        const Column(
                          children: [
                            SizedBox(height: 10),
                            Align(
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
                          ],
                        ),
                      if (_showConfirmationInput)
                        if (_showConfirmationInput)
                          TextField(
                            controller: _confirmationController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: "Type '1234' to confirm",
                              labelStyle: TextStyle(color: Colors.black), // Label color
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Underline color
                              ),
                            ), // Text color
                          ),
                      if (_wrongConfirmation)
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Incorrect! Please try again.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.left,
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
                              child: Text(
                                _showConfirmationInput ? 'BACK' : 'CANCEL',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (_showConfirmationInput) {
                                  if (_confirmationController.text == '1234') {
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
                                  } else {
                                    setState(() {
                                      _wrongConfirmation = true;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    _showConfirmationInput = true;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff284b63),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                _showConfirmationInput ? 'CONFIRM' : 'CONFIRM',
                                style: const TextStyle(
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