import 'package:flutter/material.dart';
import 'camera.dart';
import 'package:mobile_app/help_popup.dart';
import 'package:mobile_app/hero_dialog_route.dart';

class MainMenu extends StatefulWidget{
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenu();
}

class _MainMenu extends State<MainMenu>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        flexibleSpace: Center(
          child: Image.asset(
            'assets/images/logo_text.png', 
            fit: BoxFit.contain,
            height: 40,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/question_mark.png',
              fit: BoxFit.contain,
              height: 40,
            ),// image asset 
            onPressed: (){
              Navigator.of(context).push(HeroDialogRoute(
                builder: (context){
                return const HelpPopup();
                },
              ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height:20.0),
          Container(
            width: double.infinity,
            height: 100.0,
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Color(0xFF639598),
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Total Cracks Recorded',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0, 
                  ),
                ),
              ),
            ),
            //add child widgets
          ),//1container
          SizedBox(height:10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRoundedBox(),
              _buildRoundedBox(),
              _buildRoundedBox(),
              _buildRoundedBox(),
            ],
          ),
          SizedBox(height:50.0),
          Container(
            width: double.infinity,
            height: 320.0,
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Color(0xFF284B63),
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, top: 30),
                child: Text(
                  'Recent Captures',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0, 
                  ),
                ),
              ),
            ),
            //add child widgets
          ),//2container
          BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Image.asset(
                  'assets/images/gallery_icon.png',
                  fit: BoxFit.contain,
                  height: 40,
                  ),// image asset 
                  onPressed: () {
                    // Navigate to the gallery
                  },
                ),
                IconButton(
                  icon: Image.asset(
                  'assets/images/camera_icon_blue.png',
                  fit: BoxFit.contain,
                  height: 40,
                  ),// image asset 
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Navigate to quit
                  },
                ),
              ],
            ),
          ),//bottomAppBar
        ],//children
      )
    );
  }
  Widget _buildRoundedBox() {
    return Container(
      width: 90.0,
      height: 120.0,
      decoration: BoxDecoration(
        color: Colors.grey, // You can set your desired color
        borderRadius: BorderRadius.circular(15.0),
      ),
      // Add child widgets or content inside the rounded box if needed
    );
  }
}