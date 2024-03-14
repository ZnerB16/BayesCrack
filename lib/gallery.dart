import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'camera.dart';
import 'main_menu.dart'; 
import 'folders.dart';
import 'delete_folder_popup.dart';

List<String> folders = 
[
'Tracking No. 1', 
'Tracking No. 2', 
'Tracking No. 3',
'Tracking No. 4'
]; // placeholder folderssssssss

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}


class _GalleryScreenState extends State<GalleryScreen> {
  List<String> checkedFolders = []; // List to hold checked folders

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FolderListView(
              folders: folders,
              onCheckboxChanged: (folder, isChecked) {
                setState(() {
                  if (isChecked) {
                    checkedFolders.add(folder); // Add folder to the list when checked
                  } else {
                    checkedFolders.remove(folder); // Remove folder from the list when unchecked
                  }
                });
              },
            ),
          ),
          Visibility(
            visible: checkedFolders.isNotEmpty,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
              width: 70, // Set width to desired size
              height: 70, // Set height to desired size
              child: IconButton(
                onPressed: () {
                  // Show delete image popup
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteFolderPopup();
                    },
                  );
                },
                icon: Image.asset('assets/images/delete2.png'), // Use delete.png asset
              ),
            ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}




class FolderListView extends StatelessWidget {
  final List<String> folders;
  final void Function(String, bool) onCheckboxChanged; // Callback function

  FolderListView({required this.folders, required this.onCheckboxChanged});

@override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: folders.length,
      itemBuilder: (context, index) {
        final folderName = folders[index]; // Get the folder name

        return FoldersStateful(
          child: folderName, // Pass folder name as child
          folderName: folderName, // Pass folder name to FoldersStateful
          isChecked: false, // Initially unchecked
          onCheckboxChanged: (isChecked) {
            onCheckboxChanged(folderName, isChecked); // Call the callback function with folder name and checkbox state
          },
        );
      },
    );
  }
}
//////////////////////////////

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
        leading: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainMenu()),
              ModalRoute.withName('/'),
            );
          },
          child: Row(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Color(0xff284b63),
                  BlendMode.modulate,
                ),
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: Image.asset('assets/images/back_icon.png'),
                ),
              ),
              Text(
                '',
                style: TextStyle(
                  color: Color(0xff284b63),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
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
      if (_selectedIndex == 0) {
      // If the gallery button is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GalleryScreen()), 
      );
      } else if (_selectedIndex == 1) {
        // If the camera button is clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraScreen()), 
        );
      } else if (_selectedIndex == 2) {
        // If the quit button is clicked
        SystemNavigator.pop(); // This will exit the app
          }
        }
    );
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
