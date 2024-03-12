import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the SystemNavigator
import 'camera.dart'; // Import the camera.dart file

void main() {
  runApp(GalleryScreen());
}

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(),
        body: Placeholder(), // Placeholder for the body content
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 50); // Increased height by 50

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: AppBar(
        title: null, // Remove the title
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar shadow
        flexibleSpace: Center(
          child: Image.asset(
            'assets/images/logo_text.png', // Path to your logo image
            height: kToolbarHeight + 20, // Increased image height
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        // If the camera button is clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraScreen()), // Navigate to CameraScreen
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
      decoration: BoxDecoration(
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
        unselectedItemColor: Colors.grey, // Change the unselected item color if needed
        selectedIconTheme: IconThemeData(color: Colors.black), // Change the color of the line
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold), // Make the selected label bold
      ),
    );
  }
}
