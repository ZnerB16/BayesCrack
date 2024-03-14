import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the SystemNavigator
import 'main_menu.dart';
import 'folders.dart';

class GalleryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(),
        body: FolderListView(),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

class FolderListView extends StatelessWidget {

 final List _folders = [
    'Tracking No. 1',
    'Tracking No. 2',
    'Tracking No. 3',
    'Tracking No. 4',
    'Tracking No. 5',
    'Tracking No. 6',
    'Tracking No. 7',
    'Tracking No. 9',
    'Tracking No. 10',
    'Tracking No. 11',
    'Tracking No. 12',
    'Tracking No. 13',
    'Tracking No. 14',
    'Tracking No. 15',
    'Tracking No. 16',
    'Tracking No. 17',];  //placeholder folders

  @override
  Widget build(BuildContext context){
    return Scaffold (
        body:ListView.builder(
          itemCount: _folders.length,
          itemBuilder: (context, index) {
            return Folders(
              child: _folders[index],
            );
          }),
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
