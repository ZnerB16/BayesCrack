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

  // Perform classification
  Future<String> classify(String imagePath) async {
    try {
      // Read image file
      img.Image? image = img.decodeImage(File(imagePath).readAsBytesSync());
      print('Image loaded from: $image');
      print('Image size: ${image?.length} bytes');

      // Resize image to 227x227
      img.Image resizedImage = img.copyResize(image!, width: 227, height: 227);

      // Convert to Uint8List
      Uint8List convertedImage = Uint8List.fromList(resizedImage.getBytes());

      // Reshape convertedImage to match input tensor shape [1, 227, 227, 3]
      Uint8List reshapedImage = Uint8List(1 * 227 * 227 * 3);
      for (int i = 0; i < 227; i++) {
        for (int j = 0; j < 227; j++) {
          for (int k = 0; k < 3; k++) {
            reshapedImage[i * 227 * 3 + j * 3 + k] = convertedImage[k * 227 * 227 + i * 227 + j];
          }
        }
      }

      print('Image preprocessed.');
      print('Processed image shape: ${resizedImage.width}x${resizedImage.height}');
      print('Processed image data type: ${convertedImage.runtimeType}');
      print('Processed image size: ${convertedImage.length} bytes');

      // Perform classification
      final inputTensor = _interpreter.getInputTensors()[0];
      print('Input tensor shape before setting data: ${inputTensor.shape}');
      print('Display my image tensor shape: ${inputTensor.data.shape}');
      inputTensor.data = reshapedImage;
      _interpreter.invoke();

      // Get the output tensor and process results
      final outputTensor = _interpreter.getOutputTensors()[0];
      String classificationResult =
          processOutput(outputTensor.data.buffer.asFloat32List());
      print('Classification result: $classificationResult');

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
