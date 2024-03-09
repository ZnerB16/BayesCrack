import 'package:flutter/material.dart';
import 'package:mobile_app/custom_rect_tween.dart';
import 'package:mobile_app/hero_dialog_route.dart';

class HelpPopup extends StatelessWidget{
  const HelpPopup ({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Help-hero",
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
                width: 400,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "WELCOME!",
                          style: TextStyle(
                              color: Color(0xff284b63),
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      const Text(
                        "Experience a revolutionary leap in concrete crack severity classification with CIC - Crack Identification Classifier. ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                        Center(
                          child: Image.asset(
                            'assets/images/logo_text.png',
                            height: 100,
                          ),
                        ),
                  
                      Padding(padding: EdgeInsets.only(top: 20)),
                      const Text(
                        "It is crafted with a deep learning model named “BayesCrack Convolutional Ensemble” to empower a swift and accurate process of classifying concrete cracks severity.",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 100)),
                      SizedBox(
                          width: 300,
                          child: Center(
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
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
                                    alignment: Alignment.bottomRight,
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
                                              Navigator.pushReplacement(
                                                // Insert image saved
                                                  context, HeroDialogRoute(builder: (_) => const HelpPopup2())
                                              );
                                            },
                                            child: const Text(
                                              'NEXT',
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
//page 2
class HelpPopup2 extends StatelessWidget{
  const HelpPopup2 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Help-hero",
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
                width: 400,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "HOW DOES IT WORK?",
                          style: TextStyle(
                              color: Color(0xff284b63),
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      const Text(
                        "Step 1: Capture image of cracks.",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                        Center(
                          child: Image.asset(
                            'assets/images/camera_icon_blue.png',
                            height: 100,
                          ),
                        ),
                  
                      Padding(padding: EdgeInsets.only(top: 20)),
                      const Text(
                        "Step 2: Confirm and wait to classify.",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                        Center(
                          child: Image.asset(
                            'assets/images/loading_icon.gif',
                            height: 100,
                          ),
                        ),
                      Padding(padding: EdgeInsets.only(top: 100)),
                      SizedBox(
                          width: 300,
                          child: Center(
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
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
                                    alignment: Alignment.bottomRight,
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
                                              Navigator.pushReplacement(
                                                // Insert image saved
                                                  context, HeroDialogRoute(builder: (_) => const HelpPopup3())
                                              );
                                            },
                                            child: const Text(
                                              'NEXT',
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
//page 3
class HelpPopup3 extends StatelessWidget{
  const HelpPopup3 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Help-hero",
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
                width: 400,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "HOW DOES IT WORK?",
                          style: TextStyle(
                              color: Color(0xff284b63),
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      const Text(
                        "Step 3: Check the report.",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                        Center(
                          child: Image.asset(
                            'assets/images/crack_classification.png',
                            height: 120,
                          ),
                        ),
                  
                      Padding(padding: EdgeInsets.only(top: 20)),
                      const Text(
                        "Step 4: Save the Image (Optional)",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                        Center(
                          child: Image.asset(
                            'assets/images/crack_information.png',
                            height: 110,
                          ),
                        ),
                      Padding(padding: EdgeInsets.only(top: 100)),
                      SizedBox(
                          width: 300,
                          child: Center(
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
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
                                    alignment: Alignment.bottomRight,
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
                                              Navigator.pushReplacement(
                                                // Insert image saved
                                                  context, HeroDialogRoute(builder: (_) => const HelpPopup4())
                                              );
                                            },
                                            child: const Text(
                                              'NEXT',
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
//page 4
class HelpPopup4 extends StatelessWidget{
  const HelpPopup4 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Help-hero",
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
                width: 400,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "THE DEVELOPERS",
                          style: TextStyle(
                              color: Color(0xff284b63),
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Image.asset(
                            'assets/images/raven.png',
                            height: 80,
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          const Text(
                            "Raven E. Cagulang",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Image.asset(
                            'assets/images/francis.png',
                            height: 80,
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          const Text(
                            "Francis Ryan C. Diesto",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Image.asset(
                            'assets/images/brenz.png',
                            height: 80,
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          const Text(
                            "Brenz Gwynne M. Hababag",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Image.asset(
                            'assets/images/kyra.png',
                            height: 80,
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          const Text(
                            "Kyra Jyne A. Melendres",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 100)),
                      SizedBox(
                          width: 300,
                          child: Center(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 150,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
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
                                              Navigator.pop(context);
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
