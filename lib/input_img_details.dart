import 'package:flutter/material.dart';
import 'package:mobile_app/save_image_popup.dart';
import 'package:mobile_app/hero_dialog_route.dart';

class CrackInput extends StatefulWidget{
  final String? imagePath;
  final String? formattedDateTime;
  final double? latitude;
  final double? longitude;
  final String? classificationResult;

  const CrackInput (
      {
        super.key,
        this.imagePath,
        this.formattedDateTime,
        this.latitude,
        this.longitude,
        this.classificationResult
      });

  @override
  State<CrackInput> createState() => _CrackInput();
}
class _CrackInput extends State<CrackInput>{
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
            createTextField('Crack Tracking Number  (Numeric Input only)', isNumber: true),
            const Padding(padding: EdgeInsets.only(top: 10)),
            createTextField('Building Name / Number'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            createTextField('Floor Name / Number'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            createTextField('Room Name / Number'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            createTextField('Remarks/Note (OPTIONAL)', height: 150),
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
                        Navigator.pop(context);
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
  SizedBox createTextField(String text, {double height = 50.0, bool isNumber = false}){
    TextInputType keyboard = TextInputType.text;
    if(isNumber){
      keyboard = TextInputType.number;
    }
    return SizedBox(
      width: 300,
      height: height,
      child: TextField(
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
        maxLines: 10,
        style: const TextStyle(
            fontSize: 12
        ),
      ),
    );
  }
}
