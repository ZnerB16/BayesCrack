import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:mobile_app/custom_rect_tween.dart';
import 'package:mobile_app/data_display_test.dart';
import 'package:mobile_app/database/crack_db.dart';
import 'package:mobile_app/hero_dialog_route.dart';
import 'package:mobile_app/main_menu.dart';
import 'input_img_details.dart';
import 'globals.dart' as globals;

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

  void getID() async {
    var crackDB = CrackDB();
    var imageList = await crackDB.getLatestImage();
    var buildList = await crackDB.getLatestBuilding();
    var floorList = await crackDB.getLatestFloor();
    var roomList = await crackDB.getLatestFloor();

    setState(() {
      imageID = imageList[0].id;
      buildingID = buildList[0].id;
      floorID = floorList[0].id;
      roomID = roomList[0].id;
    });
  }
  @override
  void initState(){
    super.initState();
    getID();
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
                                              await GallerySaver.saveImage(globals.imagePath);
                                              var crackDB = CrackDB();
                                              crackDB.insertImage(
                                                  imagePath: globals.imagePath,
                                                  datetime: globals.formattedDateTime,
                                                  geolocation: globals.geolocation
                                              );
                                              crackDB.insertBuilding(
                                                  buildingName: globals.building
                                              );
                                              getID();
                                              crackDB.insertFloor(
                                                  floorName: globals.floor,
                                                  buildingID: buildingID
                                              );
                                              crackDB.insertRoom(
                                                  roomName: globals.room,
                                                  buildingID: buildingID,
                                                  floorID: floorID
                                              );
                                              crackDB.insertCrackInfo(
                                                  imageID: imageID,
                                                  trackingNo: globals.trackingNo,
                                                  buildingID: buildingID,
                                                  floorID: floorID,
                                                  roomID: roomID,
                                                  remarks: globals.remarks
                                              );

                                              crackDB.insertPrediction(
                                                  prediction: globals.classificationResult,
                                                  recommendation: globals.recommend,
                                                  imageID: imageID
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

                                              Navigator.push(
                                                // Insert image saved
                                                  context, MaterialPageRoute(builder: (_) => const MainMenu())
                                              );
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
