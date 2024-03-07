import 'package:flutter/material.dart';
import 'package:mobile_app/custom_rect_tween.dart';
import 'input_img_details.dart';

class SaveImagePopup extends StatelessWidget{
  const SaveImagePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Save-image-hero",
          createRectTween: (begin, end){
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)
            ),
            child: SizedBox(
                width: 300,
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                      Padding(padding: EdgeInsets.only(top: 20)),
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
                                            onPressed: (){
                                              Navigator.push(
                                                // Insert image saved
                                                  context, MaterialPageRoute(builder: (_) => const CrackInput())
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
