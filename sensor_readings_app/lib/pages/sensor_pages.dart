import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math'; // For trigonometry functions like atan2

class AccelerometerPage extends StatefulWidget {
  @override
  _AccelerometerPageState createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {
  AccelerometerEvent? _accelerometerEvent;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerEvent = event;
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accelerometer Data'),
      ),
      body: Center(
        child: Text(
          'X: ${_accelerometerEvent?.x?.toStringAsFixed(2) ?? "N/A"}, '
          'Y: ${_accelerometerEvent?.y?.toStringAsFixed(2) ?? "N/A"}, '
          'Z: ${_accelerometerEvent?.z?.toStringAsFixed(2) ?? "N/A"}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class GyroscopePage extends StatefulWidget {
  @override
  _GyroscopePageState createState() => _GyroscopePageState();
}

class _GyroscopePageState extends State<GyroscopePage> {
  GyroscopeEvent? _gyroscopeEvent;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      setState(() {
        _gyroscopeEvent = event;
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gyroscope Data'),
      ),
      body: Center(
        child: Text(
          'X: ${_gyroscopeEvent?.x?.toStringAsFixed(2) ?? "N/A"}, '
          'Y: ${_gyroscopeEvent?.y?.toStringAsFixed(2) ?? "N/A"}, '
          'Z: ${_gyroscopeEvent?.z?.toStringAsFixed(2) ?? "N/A"}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class MagnetometerPage extends StatefulWidget {
  @override
  _MagnetometerPageState createState() => _MagnetometerPageState();
}

class _MagnetometerPageState extends State<MagnetometerPage> {
  MagnetometerEvent? _magnetometerEvent;
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;

  @override
  void initState() {
    super.initState();
    _magnetometerSubscription = magnetometerEvents.listen((event) {
      setState(() {
        _magnetometerEvent = event;
      });
    });
  }

  @override
  void dispose() {
    _magnetometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magnetometer Data'),
      ),
      body: Center(
        child: Text(
          'X: ${_magnetometerEvent?.x?.toStringAsFixed(2) ?? "N/A"}, '
          'Y: ${_magnetometerEvent?.y?.toStringAsFixed(2) ?? "N/A"}, '
          'Z: ${_magnetometerEvent?.z?.toStringAsFixed(2) ?? "N/A"}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class OrientationPage extends StatefulWidget {
  @override
  _OrientationPageState createState() => _OrientationPageState();
}

class _OrientationPageState extends State<OrientationPage> {
  double _w = 0.0; // Angular velocity around the z-axis (Yaw)
  double _x = 0.0; // Angular velocity around the x-axis (Roll)
  double _y = 0.0; // Angular velocity around the y-axis (Pitch)
  double _z = 0.0; // Yaw component

  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();

    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      setState(() {
        // Capture angular velocities for w, x, y, z
        // _w = event.alpha ?? 0.0; // Assuming Gyroscope provides these values
        _x = event.x;
        _y = event.y;
        _z = event.z;
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orientation Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('OriInc_w: ${_w.toStringAsFixed(2)}'),
            Text('OriInc_x: ${_x.toStringAsFixed(2)}'),
            Text('OriInc_y: ${_y.toStringAsFixed(2)}'),
            Text('OriInc_z: ${_z.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

class OrientationPage2 extends StatefulWidget {
  @override
  _OrientationPage2State createState() => _OrientationPage2State();
}

class _OrientationPage2State extends State<OrientationPage2> {
  // Add more orientation-related data here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional Orientation Data'),
      ),
      body: Center(
        child: Text('Additional Data Goes Here'),
      ),
    );
  }
}
