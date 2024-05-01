import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/get_geolocation.dart';
import 'classify.dart';
import 'globals.dart';
import 'main_menu.dart';
import 'severity_result.dart';
import 'loading_screen.dart';
import 'globals.dart' as globals;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;
  bool _isFlashOn = false;

  String formattedDateTime = "";
  late String geolocation;
  double latitude = 0.0;
  double longitude = 0.0;

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
        ResolutionPreset.veryHigh,
      );
      _initializeControllerFuture = _controller.initialize();
      // Set flash mode to off initially
      _controller.setFlashMode(FlashMode.off);
    }).catchError((error) {
      //print('Error initializing cameras: $error');
    });
  }
  Future<void> getDetails() async{
    // Get current date and time
    DateTime now = DateTime.now();
    formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    // Get current location
    Location location = Location();
    LocationData currentLocation = await location.getLocation();
    latitude = currentLocation.latitude!;
    longitude = currentLocation.longitude!;
    globals.formattedDateTime = formattedDateTime;

  }
  Future<void> getGeolocation() async{
    await GetAddress(latitude: latitude, longitude: longitude).getAddressFromLatLng().then((String result){
      setState(() {
        geolocation = result;
      });
    });
    globals.geolocation = geolocation;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff284b63),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Camera',
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Image.asset('assets/images/back_icon.png'),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainMenu()), 
              ModalRoute.withName('/'),
            );
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
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Fit in the concrete crack you want to capture',
              style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 85.0, right: 50.0),
            child: SizedBox(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                onPressed: () async {
                  
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const LoadingScreen();
                      },
                    );

                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Attempt to take a picture and get the file `image`
                    // where it was saved.
                    final image = await _controller.takePicture();
                    if (!context.mounted) return;

                    // Turn off flash after capturing the image
                      await _controller.setFlashMode(FlashMode.off);
                      setState(() {
                        _isFlashOn = false;
                      });

                    await getDetails();

                    try{
                      await getGeolocation().timeout(const Duration(seconds: 8));
                    } on PlatformException{
                      globals.geolocation = "Geolocation or Network not found";
                    } on TimeoutException{
                      globals.geolocation = "Process took too long";
                    }

                    globals.imagePath = image.path;
                    Navigator.of(context, rootNavigator: true).pop(); 

                    // Navigate to the DisplayPictureScreen with the image path
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DisplayPictureScreen(),
                      ),
                    );
                  } catch (e) {
                    //print(e);
                  }
                },
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: const BorderSide(color: Colors.transparent),
                ),
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/capture_icon.png'),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              _toggleFlash();
            },
            backgroundColor: Colors.white,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.transparent),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            mini: true,
            child: Transform.scale(
              scale: 1.0,
              child: Icon(
                _isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: const Color(0xff284b63),
              ),
            ),
          ),
        ],
      ),
    );
  }

    void _toggleFlash() async {
    try {
      // Toggle the flash mode
      if (_isFlashOn) {
        // Turn off the flash
        await _controller.setFlashMode(FlashMode.off);
      } else {
        // Turn on the flash
        await _controller.setFlashMode(FlashMode.torch);
      }
      
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      //print('Error toggling flashlight: $e');
    }
  }
}

class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation',
          style: TextStyle(
              color: Color(0xff284b63),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      // Start of Column body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Displays Image captured
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff284b63), width: 2.0),
                  ),
                  constraints: const BoxConstraints(maxHeight: 450),
                  child: Image.file(File(globals.imagePath)),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Run severity classification on this image?',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: 250,
                    child: Text(
                      'Date Time: $formattedDateTime \nGeolocation: $geolocation',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ),
              ],
            ),
          ),
          // Button for Cancel
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate back to the camera screen
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffd9d9d9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Button for Confirm
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                   onPressed: () async {   
                       
                       showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const LoadingScreen();
                        },
                      );

                      await Future.delayed(const Duration(milliseconds: 1000));

                      // Instantiate Classifier
                      Classifier classifier = Classifier();

                      await classifier.loadModel();

                      // Perform classification
                      globals.classificationResult = await classifier.classify(globals.imagePath);

                      // Dispose model
                      await classifier.disposeModel();

                      Navigator.of(context, rootNavigator: true).pop(); 

                      // Navigate to SeverityResultScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SeverityResultScreen(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff284b63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'CONFIRM',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // End of Column Body
    );
  }
}
