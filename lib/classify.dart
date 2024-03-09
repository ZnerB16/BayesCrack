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

  // Preprocess image to match model input size (227x227) and normalize pixel values
  List<double> preprocessImage(Uint8List image) {
    // Decode the image using image package
    img.Image? imgData = img.decodeImage(image);
    if (imgData == null) {
      throw Exception('Failed to decode image');
    }
    // Resize the image to 227x227
    imgData = img.copyResize(imgData, width: 227, height: 227);
    // Convert Uint8List to List<int> for element-wise operations
    Uint8List pixelData = imgData.getBytes();

    // Normalize the pixel values to [0, 1] and convert to Uint8List
    List <double> normalizedPixels = pixelData.map((pixel) => pixel / 255.0).toList();
    Uint8List.fromList(normalizedPixels.map((pixel) => (pixel * 255).toInt()).toList());

    // Print normalized pixel values
    print('Normalized pixel values: $normalizedPixels');

    return normalizedPixels;
}

  // Perform inference on image
  Future<String> classify(imagePath) async {
    try {
      
      final inputTensors = _interpreter.getInputTensors();
      final outputTensors = _interpreter.getOutputTensors();

      print('Input tensors: $inputTensors');
      print('Output tensors: $outputTensors');

      if (inputTensors.isEmpty || outputTensors.isEmpty) {
        throw Exception('Input or output tensors are null or empty');
      }
      // Load and preprocess image
      Uint8List imageBytes = await File(imagePath).readAsBytes();
      print('Image loaded: $imageBytes');
      print('Image size: ${imageBytes.length} bytes');

      Uint8List imageDimensions = preprocessImage(imageBytes) as Uint8List;
      print('Image preprocessed.');
      print('Processed image shape: ${imageDimensions[0]}x${imageDimensions[1]}');
      print('Processed image data type: ${imageDimensions.runtimeType}');
      print('Processed image size: ${imageDimensions.length} bytes');

      // Perform inference
      final inputTensor = inputTensors[0];
      print('Input tensor shape before setting data: ${inputTensor.shape}');
      inputTensor.data = imageDimensions;
      print('Input tensor data set');
      _interpreter.invoke();
      print('Inference completed.');

      // Get the output tensor and process results
      final outputTensor = _interpreter.getOutputTensors()[0];
      print('Output tensor shape: ${outputTensor.shape}');
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
