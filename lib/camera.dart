import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/get_geolocation.dart';
import 'classify.dart';
import 'severity_result.dart';
import 'loading_screen.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

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
      print('Error initializing cameras: $error');
    });
  }
  Future<void> getDetails() async{
    // Get current date and time
    DateTime now = DateTime.now();
    formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    // Get current location
    Location location = Location();
    LocationData? currentLocation = await location.getLocation();
    latitude = currentLocation.latitude!;
    longitude = currentLocation.longitude!;
    GetAddress(latitude: latitude, longitude: longitude).getAddressFromLatLng().then((String result){
      setState(() {
        geolocation = result;
      });
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
      backgroundColor: Color(0xff284b63),
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
          SizedBox(height: 100),
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
                        return LoadingScreen();
                      },
                    );

                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Set flash mode to on just before capturing the image
                    if (_isFlashOn) {
                      await _controller.setFlashMode(FlashMode.torch);
                    }

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
                    
                    Navigator.of(context, rootNavigator: true).pop(); 

                    // Navigate to the DisplayPictureScreen with the image path
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                          imagePath: image.path,
                          onConfirm: (bool confirmed) {
                            if (confirmed) {
                              // Handle confirmation action here
                              // For now, just navigate back to CameraScreen
                              Navigator.pop(context);
                            }
                          },
                          formattedDateTime: formattedDateTime,
                          geolocation: geolocation,
                          latitude: latitude,
                          longitude: longitude,
                        ),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.transparent),
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
            child: Transform.scale(
              scale: 1.0,
              child: Icon(
                _isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Color(0xff284b63),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.transparent),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            mini: true,
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
      print('Error toggling flashlight: $e');
    }
  }
}


class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final Function(bool) onConfirm;
  final String formattedDateTime;
  final String geolocation;
  final double latitude;
  final double longitude;

  const DisplayPictureScreen({
    Key? key,
    required this.imagePath,
    required this.onConfirm,
    required this.formattedDateTime,
    required this.geolocation,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation',
          style: TextStyle(
              color: Color(0xff284b63),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff284b63), width: 2.0),
                  ),
                  constraints: BoxConstraints(maxHeight: 450),
                  child: Image.file(File(imagePath)),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Run severity classification on this image?',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    width: 250,
                    child: Text(
                      'Date Time: $formattedDateTime\nGeolocation: $geolocation',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ),
              ],
            ),
          ),
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
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                   onPressed: () async {   
                       
                       showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return LoadingScreen();
                        },
                      );

                      await Future.delayed(Duration(milliseconds: 1000));

                      // Instantiate Classifier
                      Classifier classifier = Classifier();

                      await classifier.loadModel();

                      // Perform classification
                      String classificationResult = await classifier.classify(imagePath);

                      // Dispose model
                      await classifier.disposeModel();

                      Navigator.of(context, rootNavigator: true).pop(); 

                      // Navigate to SeverityResultScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeverityResultScreen(
                            classificationResult: classificationResult,
                            imagePath: imagePath,
                            formattedDateTime: formattedDateTime,
                            geolocation: geolocation,
                            longitude: longitude,
                            latitude: latitude,
                          ),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff284b63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
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
    );
  }
}
