import 'package:flutter/material.dart';
import 'package:mobile_app/database/classes/crack_info.dart';
import 'database/crack_db.dart';
import 'main_menu.dart';
import 'folders.dart';
import 'delete_folder_popup.dart';


List<String> folders = [];

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> checkedFolders = []; // List to hold checked folders
  List<CrackInfo> listTrack = [];
  // placeholder folders

  var crackDB = CrackDB();

  void getTrackingNo() async{

    listTrack = await crackDB.getTrackingNos();

    setState(() {
      int currentTrack = 0;

      for(int i = 0; i < listTrack.length; i++){
        currentTrack = listTrack[i].trackingNo;
        folders.add("Tracking No. $currentTrack");
      }
    });
  }

  @override
  void initState(){
    super.initState();
    folders = [];
    getTrackingNo();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(),
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
              child: SizedBox(
                width: 70, // Set width to desired size
                height: 70, // Set height to desired size
                child: IconButton(
                  onPressed: () {
                    // Show delete image popup
                    // Show delete image popup
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            DeleteFolderPopup(
                              trackingNo: checkedFolders,
                            )).then((value) { setState(() {
                                folders = [];
                                checkedFolders = [];
                                getTrackingNo();
                                });
                            });
                  },
                  icon: Image.asset('assets/images/delete2.png'), // Use delete.png asset
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(), // Add CustomBottomNavigationBar here
    );
  }
}

class FolderListView extends StatefulWidget {
  final List<String> folders;

  final void Function(String, bool) onCheckboxChanged; // Callback function

  const FolderListView({super.key, required this.folders, required this.onCheckboxChanged});

  @override
  State<FolderListView> createState() => _FolderListViewState();
}

class _FolderListViewState extends State<FolderListView> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: folders.length,
      itemBuilder: (context, index) {
        final folderName = folders[index]; // Get the folder name

        return FoldersStateful(
          child: folderName, // Pass folder name as child
          trackingNo: int.parse(folderName.replaceAll(RegExp(r'[^0-9]'),'')),
          folderName: folderName, // Pass folder name to FoldersStateful
          isChecked: false, // Initially unchecked
          onCheckboxChanged: (isChecked) {
            widget.onCheckboxChanged(folderName, isChecked); // Call the callback function with folder name and checkbox state
          },
        );
      },
    );
  }
}

//////////////////////////////
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50); // Increased height by 50
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
              MaterialPageRoute(builder: (context) => const MainMenu()),
              ModalRoute.withName('/'),
            );
          },
          child: Row(
            children: [
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xff284b63),
                  BlendMode.modulate,
                ),
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: Image.asset('assets/images/back_icon.png'),
                ),
              ),
              const Text(
                'Back',
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