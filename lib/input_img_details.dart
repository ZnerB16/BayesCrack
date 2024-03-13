import 'package:flutter/material.dart';
import 'package:mobile_app/camera.dart';
import 'package:mobile_app/save_image_popup.dart';
import 'package:mobile_app/hero_dialog_route.dart';
import 'globals.dart' as globals;

class CrackInput extends StatefulWidget{

  const CrackInput ({super.key,});

  @override
  State<CrackInput> createState() => _CrackInput();
}
class _CrackInput extends State<CrackInput>{
  final _controllerTrackingNo = TextEditingController();
  final _controllerBuilding = TextEditingController();
  final _controllerFloor = TextEditingController();
  final _controllerRoom = TextEditingController();
  final _controllerRemarks = TextEditingController();
  String trackingNo = "";
  String building = "";
  String floor = "";
  String room = "";
  String remarks = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              /// Title text
              child: Text(
                  "Crack Information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  )
              )
            ),
            /// Description text
            const Text(
                "Enter the required information of the image below.\n\nNote: Crack Tracking Number will serve as the folder name where the image will be saved.",
              style: TextStyle(
                fontSize: 12
              ),
            ),
            /// Start text fields
            const Padding(padding: EdgeInsets.only(top: 30)),
            createTextField('Crack Tracking Number  (Numeric Input only)', isNumber: true, controller: _controllerTrackingNo),
            const Padding(padding: EdgeInsets.only(top: 10)),
            createTextField('Building Name / Number', controller: _controllerBuilding),
            const Padding(padding: EdgeInsets.only(top: 10)),
            createTextField('Floor Name / Number', controller: _controllerFloor),
            const Padding(padding: EdgeInsets.only(top: 10)),
            createTextField('Room Name / Number', controller: _controllerRoom),
            const Padding(padding: EdgeInsets.only(top: 10)),
            createTextField('Remarks/Note (OPTIONAL)', height: 150, controller: _controllerRemarks, maxLines: 10),
            const Padding(padding: EdgeInsets.only(top: 20)),
            /// End text fields

            /// Start Cancel and Done button
            SizedBox(
              width: 500,
              child: Row(mainAxisAlignment: MainAxisAlignment.end,
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
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return const CameraScreen();
                        }));
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
                    width: 10,
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
                        onPressed: (){
                          setState(() {
                            trackingNo = _controllerTrackingNo.text;
                            building = _controllerBuilding.text;
                            floor = _controllerFloor.text;
                            room = _controllerRoom.text;
                            remarks = _controllerRemarks.text;
                          });
                          globals.trackingNo = int.parse(trackingNo);
                          globals.building = building;
                          globals.floor = floor;
                          globals.room = room;
                          globals.remarks = remarks;

                            Navigator.of(context).push(HeroDialogRoute(
                                builder: (context){
                                    return const SaveImagePopup();
                                  },
                              ));
                        },
                        child: const Text(
                          'DONE',
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
          ],
          /// End cancel and done button
        ),
      )
    );
  }
  /// Text field creation function
  SizedBox createTextField(String text, {double height = 50.0, bool isNumber = false, required TextEditingController controller, int maxLines = 1}){
    TextInputType keyboard = TextInputType.text;
    if(isNumber){
      keyboard = TextInputType.number;
    }
    return SizedBox(
      width: 300,
      height: height,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff284b63), width: 2.0),
                borderRadius: BorderRadius.zero
            ),
            hintText: text,
            filled: true,
            fillColor: Colors.black12
        ),
        keyboardType: keyboard,
        maxLines: maxLines,
        style: const TextStyle(
            fontSize: 12
        ),
      ),
    );
  }
}
