import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:tflite_flutter/tflite_flutter.dart'; // To load TensorFlow Lite model
import 'dart:async';
import 'dart:math';

class SensorDataPage extends StatefulWidget {
  @override
  _SensorDataPageState createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage> {
  Interpreter? _interpreter; // For running TensorFlow Lite model
  Timer? _dataCaptureTimer;

  // Sensor data variables
  double velIncX = 0.0;
  double velIncY = 0.0;
  double velIncZ = 0.0;

  double oriIncW = 0.0;
  double oriIncX = 0.0;
  double oriIncY = 0.0;
  double oriIncZ = 0.0;

  double accX = 0.0;
  double accY = 0.0;
  double accZ = 0.0;

  double gyrX = 0.0;
  double gyrY = 0.0;
  double gyrZ = 0.0;

  double magX = 0.0;
  double magY = 0.0;
  double magZ = 0.0;

  double roll = 0.0;
  double pitch = 0.0;
  double yaw = 0.0;

  // Sensor subscriptions
  StreamSubscription<AccelerometerEvent>? accelerometerSubscription;
  StreamSubscription<GyroscopeEvent>? gyroscopeSubscription;
  StreamSubscription<MagnetometerEvent>? magnetometerSubscription;

  @override
  void initState() {
    super.initState();

    // Load TensorFlow Lite model
    loadTFLiteModel();

    // Schedule data capture every 3 seconds
    _dataCaptureTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      captureSensorData();
    });

    // Subscribe to sensor events
    accelerometerSubscription = accelerometerEvents.listen((event) {
      accX = event.x;
      accY = event.y;
      accZ = event.z;
    });

    gyroscopeSubscription = gyroscopeEvents.listen((event) {
      gyrX = event.x;
      gyrY = event.y;
      gyrZ = event.z;

      yaw += event.z * 0.02; // Assuming 50 Hz
      pitch += event.y * 0.02;
      roll += event.x * 0.02;
    });

    magnetometerSubscription = magnetometerEvents.listen((event) {
      magX = event.x;
      magY = event.y;
      magZ = event.z;
    });
  }

  @override
  void dispose() {
    _dataCaptureTimer?.cancel();
    accelerometerSubscription?.cancel();
    gyroscopeSubscription?.cancel();
    magnetometerSubscription?.cancel();
    super.dispose();
  }

  void loadTFLiteModel() async {
    _interpreter = await Interpreter.fromAsset('model_wp.tflite');
  }

  void captureSensorData() {
    if (_interpreter == null) {
      print('Model not loaded');
      return;
    }

    // Prepare input data for TensorFlow Lite
    List<double> input = [
      velIncX,
      velIncY,
      velIncZ,
      oriIncW,
      oriIncX,
      oriIncY,
      oriIncZ,
      accX,
      accY,
      accZ,
      gyrX,
      gyrY,
      gyrZ,
      magX,
      magY,
      magZ,
      roll,
      pitch,
      yaw,
    ];

    // Placeholder for model output (modify based on model's expected output)
    var output = List<double>.filled(1, 0.0);

    // Run inference
    _interpreter!.run(input, output);

    // Process the output or display results
    print('Model output: $output');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Data is being captured every 3 seconds.'),
            // Display sensor data or model output here as needed
          ],
        ),
      ),
    );
  }
}
