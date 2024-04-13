import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/database/classes/crack_info.dart';
import 'package:mobile_app/database/classes/image.dart';
import 'camera.dart';
import 'package:mobile_app/help_popup.dart';
import 'package:mobile_app/hero_dialog_route.dart';
import 'database/crack_db.dart';
import 'gallery.dart';
import 'image_interface.dart';
import 'recent_captures.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});
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
    var totalCount = await crackDB.countAll();
    setState(() {
      noneCount = countsNone!;
      lowCount = countsLow!;
      medCount = countsMed!;
      highCount = countsHigh!;
      total = totalCount!;
    });
  }
  List<RecentImages> recentImages = [];
  void getRecentImages() async {
    var crackDB = CrackDB();
    List<ImageDB> imageList = await crackDB.getFiveLatestImages();

    for(int i = 0; i < imageList.length; i++){
      List<CrackInfo> crackList = await crackDB.getTrackingNo(imageID: imageList[i].id);
      recentImages.add(
          RecentImages(
              trackingNo: crackList[0].trackingNo,
              imageName: 'Crack_${imageList[i].id}',
              date: imageList[i].dateTime,
              imagePath: imageList[i].imagePath
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setCounts();
    getRecentImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 85,
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/images/logo_text.png',
            height: kToolbarHeight + 20,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/question_mark.png',
              fit: BoxFit.contain,
              height: 40,
            ),
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
      body: SingleChildScrollView( //counters
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 100.0,
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: const Color(0xFF639598),
                borderRadius: BorderRadius.circular(15.0),
              ),
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          "$total",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 45.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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

            const SizedBox(height: 30.0),
            _buildRecentImagesListView(context),

            const CustomBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentImagesListView(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 320.0,
    margin: const EdgeInsets.all(0),
    decoration: BoxDecoration(
      color: const Color(0xFF284B63),
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 30),
          child: Text(
            'Recent Captures',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recentImages.length,
            itemBuilder: (context, index) {
              final imageID = recentImages[index].imageName.replaceAll(RegExp(r'[^0-9]'),'');
              final captureDate = DateTime.parse(recentImages[index].date);
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ImageInterface(
                          img_path: recentImages[index].imagePath,
                          img_id: imageID,
                          capture_date: captureDate,
                          // Pass other required parameters here
                        )), // change to point to specific image file
                      );
                    },
                    child: ListTile(
                      leading: Image.file(
                        File(recentImages[index].imagePath),
                        width: 30, // Adjust the width as needed
                        height: 30, // Adjust the height as needed
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        recentImages[index].imageName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tracking No: ${recentImages[index].trackingNo}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            recentImages[index].date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white, thickness: 1.0, height: 0.0, 
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

  Widget _buildRoundedBox({required String title, int count = 0}) {
    return Container(
      width: 90.0,
      height: 120.0,
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
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
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // If the gallery button is clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GalleryScreen()),
        );
      } else if (_selectedIndex == 1) {
        // If the camera button is clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CameraScreen()),
        );
      } else if (_selectedIndex == 2) {
        // If the quit button is clicked
        SystemNavigator.pop(); // This will exit the app
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Gallery',
            icon: Image.asset(
              'assets/images/photo.png', // Path to your gallery icon image
              width: 20, // Adjust the width of the gallery icon
              height: 20, // Adjust the height of the gallery icon
            ),
          ),
          BottomNavigationBarItem(
            label: '', // No label for the camera
            icon: Stack(
              children: [
                Center(
                  child: IconButton(
                    onPressed: () {
                      _onItemTapped(1); // Call _onItemTapped with index 1 when camera button is clicked
                    },
                    icon: Image.asset(
                      'assets/images/Camera.png', // Path to your camera icon image
                      width: 60, // Adjust the width of the camera icon
                      height: 60, // Adjust the height of the camera icon
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label: 'Quit',
            icon: Image.asset(
              'assets/images/logout.png', // Path to your quit icon image
              width: 20, // Adjust the width of the quit icon
              height: 18, // Adjust the height of the quit icon
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black, // Change the color of the selected item
        unselectedItemColor: Colors.black, // Change the color of the unselected item
        selectedLabelStyle: const TextStyle(
          fontSize: 12, // Specify the font size of the selected item text
          color: Colors.black, // Specify the font color of the selected item text
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12, // Specify the font size of the unselected item text
          color: Colors.black, // Specify the font color of the unselected item text
        ),
      ),
    );
  }
}