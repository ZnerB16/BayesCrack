import 'package:flutter/material.dart';
import 'custom_rect_tween.dart';
import 'package:mobile_app/database/classes/building.dart';
import 'package:mobile_app/database/classes/floor.dart';
import 'package:mobile_app/database/classes/image.dart';
import 'package:mobile_app/database/classes/room.dart';
import 'package:mobile_app/database/crack_db.dart';
import 'hero_dialog_route.dart';
import 'package:mobile_app/image_capture/image_saved.dart';
import 'package:mobile_app/image_capture/input_img_details.dart';
import 'package:mobile_app/globals.dart' as globals;

class SaveImagePopup extends StatefulWidget{
  const SaveImagePopup({super.key});

  @override
  State<SaveImagePopup> createState() => _SaveImagePopupState();
}

class _SaveImagePopupState extends State<SaveImagePopup> {
  int imageID = 0;
  int buildingID = 0;
  int floorID = 0;
  int roomID = 0;
  String? filePath;


  var crackDB = CrackDB();

  Future<void> getImageBuildID() async {
    List<ImageDB>? imageList = await crackDB.getLatestImageID();
    List<Building>? buildList = await crackDB.getLatestBuilding();

    if(imageList.isEmpty){
      imageID = 1;
      buildingID = 1;
    }
    else{
      setState(() {
        imageID = imageList[0].id;
        buildingID = buildList[0].id;
      });
    }
  }
  Future<void> getFloorID() async {
    List<Floor>? floorList = await crackDB.getLatestFloor();
    if(floorList.isEmpty){
      floorID = 1;
    }
    else{
      setState(() {
        floorID = floorList[0].id;
      });
    }
  }
  Future<void> getRoomID() async {
    List<Room> roomList = await crackDB.getLatestRoom();
    if(roomList.isEmpty){
      roomID = 1;
    }
    else{
      setState(() {
        roomID = roomList[0].id;
      });
    }
  }

  @override
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Save-image-hero",
          createRectTween: (begin, end){
            return CustomRectTween(begin: begin, end: end); /// Makes the rounded rectangle dialogs
          },
          child: Material(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)
            ),
            child: SizedBox(
                width: 300,
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Save Image",
                          style: TextStyle(
                              color: Color(0xff284b63),
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      const Text(
                        "Are you sure you want to save your image?",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      /// Start cancel and confirm button
                      SizedBox(
                          width: 300,
                          child: Center(
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffd9d9d9),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                                color: const Color(0xffd9d9d9)
                                            ),
                                            boxShadow:  [BoxShadow(
                                              color: Colors.black.withOpacity(0.20),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 7), // changes position of shadow
                                            ),
                                            ]
                                        ),
                                        child: TextButton(
                                            onPressed: (){
                                              Navigator.push(context, HeroDialogRoute(
                                                  builder: (context){
                                                    return const CrackInput();
                                                  }
                                              ));
                                            },
                                            child: const Text(
                                              'CANCEL',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                        )
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff284b63),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                                color: const Color(0xff284b63)
                                            ),
                                            boxShadow:  [BoxShadow(
                                              color: Colors.black.withOpacity(0.15),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 7), // changes position of shadow
                                            ),
                                            ]
                                        ),
                                        child: TextButton(
                                            onPressed: () async {

                                              var crackDB = CrackDB();

                                              await crackDB.insertImage(
                                                  imagePath: globals.imagePath,
                                                  datetime: globals.formattedDateTime,
                                                  geolocation: globals.geolocation
                                              );
                                              await crackDB.insertBuilding(
                                                  buildingName: globals.building
                                              );
                                              await getImageBuildID();
                                              await crackDB.insertFloor(
                                                  floorName: globals.floor,
                                                  buildingID: buildingID
                                              );
                                              await getFloorID();
                                              await crackDB.insertRoom(
                                                  roomName: globals.room,
                                                  buildingID: buildingID,
                                                  floorID: floorID
                                              );
                                              await getRoomID();
                                              await crackDB.insertCrackInfo(
                                                  imageID: imageID,
                                                  trackingNo: globals.trackingNo,
                                                  buildingID: buildingID,
                                                  floorID: floorID,
                                                  roomID: roomID,
                                                  remarks: globals.remarks
                                              );
                                              await crackDB.insertPrediction(
                                                  prediction: globals.classificationResult,
                                                  recommendation: globals.recommend,
                                                  imageID: imageID
                                              );


                                              await Navigator.push(
                                                // Insert image saved
                                                  context, MaterialPageRoute(builder: (_) => ImageSavedScreen(trackingNo: globals.trackingNo))
                                              );
                                              globals.recommend = "";
                                              globals.floor = "";
                                              globals.building = "";
                                              globals.geolocation = "";
                                              globals.formattedDateTime = "";
                                              globals.imagePath = "";
                                              globals.remarks = "";
                                              globals.trackingNo = 0;
                                              globals.room = "";
                                            },
                                            child: const Text(
                                              'CONFIRM',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                        )
                                    ),
                                  ),
                                ]
                            )
                          )
                      )
                      /// End cancel and confirm button
                    ],
                  ),
                )
            ),
          )
        ),
      ),
    );
  }
}
