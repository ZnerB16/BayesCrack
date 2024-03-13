import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  late Interpreter _interpreter;
  late List<String> _labels;

  // Load TensorFlow Lite model and labels
  Future<void> loadModel() async {
    try {

      // Load model
      final interpreterOptions = InterpreterOptions();
      _interpreter = await Interpreter.fromAsset(
        'assets/model/Ensemble_BCCE_Model.tflite',
        options: interpreterOptions,
      );

      // Check if interpreter is not null
      print('Model loaded successfully.');

      // Allocate tensors
      _interpreter.allocateTensors();

      // Load labels
      _labels = await loadLabels('assets/model/labels.txt');

      // Check if labels are loaded successfully
      if (_labels.isNotEmpty) {
        print('Labels loaded successfully:');
        _labels.forEach((label) => print(label));
      } else {
        print('Failed to load labels or labels file is empty.');
      }
    } catch (e) {
      print('Failed to load model: $e');
      // Handle the error, throw, or return as needed
    } 
  }

  // Load labels from a file
  Future<List<String>> loadLabels(String path) async {
    try {
      final fileData = await rootBundle.loadString(path);
      return fileData.split('\n').map((label) => label.trim()).toList();
    } catch (e) {
      print('Failed to load labels: $e');
      return <String>[];
      // Handle the error, throw, or return as needed
    }
  }

  /// Gets the interpreter instance
  Interpreter get interpreter => _interpreter;
  
  // Perform classification
  Future<String> classify(String imagePath) async {
    try {
      // Read image file
      img.Image? image = img.decodeImage(File(imagePath).readAsBytesSync());
      print('Image loaded from: $imagePath');
      print('Image size: ${image?.length} bytes');

      // Resize image to 150x150 (assuming input size)
      img.Image resizedImage =
          img.copyResize(image!, width: 227, height: 227);

      // Convert to Float32List
       Float32List convertedImage = Float32List.fromList(resizedImage.getBytes().map((pixel) => pixel / 255.0).toList());

      print('Image preprocessed.');
      print('Processed image shape: ${resizedImage.width}x${resizedImage.height}');
      print('Processed image data type: ${convertedImage.runtimeType}');
      print('Processed image size: ${convertedImage.length} bytes');

      // Print pixel values from the converted image row by row for test only
      // print('Pixel values of converted image:');
      // for (int y = 0; y < resizedImage.height; y++) {
      //  StringBuffer rowBuffer = StringBuffer();
      //  for (int x = 0; x < resizedImage.width; x++) {
      //    int pixelIndex = y * resizedImage.width + x;
      //    rowBuffer.write('${convertedImage[pixelIndex]} ');
      //  }
      //  print(rowBuffer.toString());
      //}

      final input = convertedImage.reshape([1, 227, 227, 3]);
      final output = Float32List(1 * 4).reshape([1, 4]);

      _interpreter.run(input, output);

      final predictionResult = output[0];
      int maxIndex = predictionResult.indexOf(predictionResult.reduce(
          (double maxElement, double element) =>
              element > maxElement ? element : maxElement));
      return _labels[maxIndex];
    } catch (e) {
      print('Error during classification: $e');
      return "Error";
    }
  }

  // Dispose TensorFlow Lite model
  Future<void> disposeModel() async {
    try {
      _interpreter.close();
    } catch (e) {
      print('Failed to dispose model: $e');
      // Handle the error, throw, or return as needed
    }
  }
}
