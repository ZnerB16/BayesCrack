import 'dart:typed_data';
import 'package:tflite/tflite.dart';

class Classifier {
  // Load TensorFlow Lite model
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model/Ensemble_BCCE_Model.tflite',
      labels: 'assets/model/labels.txt',
    );
  }

  // Perform inference on image
  Future<Map<String, dynamic>?> classifyImage(Uint8List image) async {
    List? recognitions = await Tflite.runModelOnBinary(
      binary: image,
      threshold: 0.1,
      numResults: 1,
    );

    // Process recognition results
    if (recognitions != null && recognitions.isNotEmpty) {
      // Get the top result
      Map<String, dynamic> result = recognitions[0];
      return result;
    } else {
      return null;
    }
  }

  // Dispose TensorFlow Lite model
  Future<void> disposeModel() async {
    await Tflite.close();
  }
}




