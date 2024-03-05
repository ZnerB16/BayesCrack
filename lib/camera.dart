import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    // Retrieve the list of available cameras
    availableCameras().then((List<CameraDescription> availableCameras) {
      setState(() {
        cameras = availableCameras;
      });
      // Initialize the camera controller
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
    }).catchError((error) {
      print('Error initializing cameras: $error');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff284b63), // Set background color here
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Camera',
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.w600
          ),
        ),
        leading: IconButton(
          icon: Image.asset('assets/images/back_icon.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0), // Add horizontal padding
            child: Text(
              'Fit in the concrete crack you want to capture',
              style: TextStyle(
                color: Color(0xffFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 100), // Add space between the sentence and the FloatingActionButton
        ],
      ),
  
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 100, // Adjust width as needed
        height: 100, // Adjust height as needed
        child: FloatingActionButton(
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller.takePicture();

              if (!context.mounted) return;

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    // Pass the automatically generated path to
                    // the DisplayPictureScreen widget.
                    imagePath: image.path,
                  ),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          elevation: 10.0, // Add depth to the button
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0), 
          side: BorderSide(color: Colors.transparent),
          ),
          backgroundColor: Colors.white, 
          child: Image.asset('assets/images/capture_icon.png'),
        ),
      ),
    );
  }

}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
