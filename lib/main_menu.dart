import 'package:flutter/material.dart';
import 'camera.dart';
import 'package:mobile_app/help_popup.dart';
import 'package:mobile_app/hero_dialog_route.dart';
import 'database/crack_db.dart';
import 'gallery.dart'; // Import the GalleryScreen

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int noneCount = 0;
  int lowCount = 0;
  int medCount = 0;
  int highCount = 0;
  int total = 0;

  void setCounts() async {
    var crackDB = CrackDB();
    var countsNone = await crackDB.countPredictions("None");
    var countsLow = await crackDB.countPredictions("Low");
    var countsMed = await crackDB.countPredictions("Medium");
    var countsHigh = await crackDB.countPredictions("High");

    setState(() {
      noneCount = countsNone[0];
      lowCount = countsLow[0];
      medCount = countsMed[0];
      highCount = countsHigh[0];
    });
  }

  @override
  void initState() {
    super.initState();
    setCounts();
  }

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
            height: 80,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/question_mark.png',
              fit: BoxFit.contain,
              height: 40,
            ), // image asset
            onPressed: () {
              Navigator.of(context).push(HeroDialogRoute(
                builder: (context) {
                  return const HelpPopup();
                },
              ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            height: 100.0,
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: const Color(0xFF639598),
                borderRadius: BorderRadius.circular(15.0)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Cracks Recorded',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          "$total",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 45.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )),
            ),
          ), //1container
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRoundedBox(title: "None", count: noneCount),
              _buildRoundedBox(title: "Low", count: lowCount),
              _buildRoundedBox(title: "Medium", count: medCount),
              _buildRoundedBox(title: "High", count: highCount),
            ],
          ),
          const SizedBox(height: 50.0),
          Container(
            width: double.infinity,
            height: 320.0,
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: const Color(0xFF284B63),
                borderRadius: BorderRadius.circular(15.0)),
            child: const Align(
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
          ), //2container
          BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/gallery_icon.png',
                    fit: BoxFit.contain,
                    height: 40,
                  ), // image asset
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GalleryScreen()), // Navigate to GalleryScreen
                    );
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/images/camera_icon_blue.png',
                    fit: BoxFit.contain,
                    height: 40,
                  ), // image asset
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CameraScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Navigate to quit
                  },
                ),
              ],
            ),
          ), //bottomAppBar
        ], //children
      ),
    );
  }

  Widget _buildRoundedBox({required String title, int count = 0}) {
    return Container(
      width: 90.0,
      height: 120.0,
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9), // You can set your desired color
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 65,
                child: Text(
                  "$count",
                  style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
