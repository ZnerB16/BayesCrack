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

      // Allocate tensors
      _interpreter.allocateTensors();

      // Load labels
      _labels = await loadLabels('assets/model/labels.txt');
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

  // Preprocess image to match model input size (227x227)
  Uint8List preprocessImage(Uint8List image) {
  // Decode the image using image package
  img.Image imgData = img.decodeImage(image)!;
  
  // Log the dimensions of the original image
  print('Original Image Dimensions: ${imgData.width}x${imgData.height}');
  
  // Resize the image to 227x227
  imgData = img.copyResize(imgData, width: 227, height: 227);
  
  // Log the dimensions of the resized image
  print('Resized Image Dimensions: ${imgData.width}x${imgData.height}');
  
  // Convert the image back to Uint8List
  Uint8List resizedImage = Uint8List.fromList(img.encodePng(imgData));
  
  return resizedImage;
}

  // Perform inference on image
  Future<String> classify(imagePath) async {
    try {
      // Load and preprocess image
      Uint8List imageBytes = await File(imagePath).readAsBytes();
      Uint8List processedImage = preprocessImage(imageBytes);

      // Perform inference
      _interpreter.getInputTensors()[0].data = processedImage;
      _interpreter.invoke();

      // Get the output tensor and process results
      final output = _interpreter.getOutputTensors()[0].data;
      String classificationResult = processOutput(output as Float32List);

      return classificationResult;
    } catch (e) {
      print('Failed to classify image: $e');
      return 'Failed to classify image';
      // Handle the error, throw, or return as needed
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

  // Process output tensor and get classification result
  String processOutput(Float32List output) {
    // Convert the output tensor to class index
    int classIndex = output[0].round();
    
    // Map class index to corresponding label
    return _labels[classIndex];
  }
}

