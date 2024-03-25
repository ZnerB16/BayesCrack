import 'package:flutter/material.dart';
import 'package:mobile_app/main_menu.dart';
import 'camera.dart';

class ImageSavedScreen extends StatelessWidget{
  int trackingNo;
  ImageSavedScreen(
  {
    super.key,
    required this.trackingNo
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/blue_checkmark.png',
              width: 200,
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              'The image has been saved in the folder named:',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            SizedBox(
              width: 300,
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff284b63), width: 2.0),
                      borderRadius: BorderRadius.zero
                  ),
                  hintText: 'Tracking No. $trackingNo',
                  filled: true,
                  fillColor: Colors.black12,
                ),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
                enabled: false,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            Container(
                width: 200,
                height: 40,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CameraScreen()),
                    );
                  },
                  child: const Text(
                    'TAKE ANOTHER PICTURE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              width: 100,
              height: 40,
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MainMenu()));
                },
                child: const Text(
                  'HOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ),
          ],
        ),
      )
    );
  }
  
}