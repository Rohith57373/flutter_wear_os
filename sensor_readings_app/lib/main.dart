import 'package:flutter/material.dart';
import 'pages/sensor_data_page.dart';
import 'pages/sensor_pages.dart'; // Importing sensor-specific pages

void main() {
  runApp(SensorReadingsApp());
}

class SensorReadingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor Readings App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SensorHomePage(), // Entry point to the app
    );
  }
}

class SensorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Readings App'),
      ),
      body: SingleChildScrollView(
        // Enable vertical scrolling
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16), // Padding around content
            child: Wrap(
              spacing: 10, // Space between buttons
              runSpacing: 10, // Space between rows
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SensorDataPage(),
                      ),
                    );
                  },
                  child:
                      Text('Data'), // Button that navigates to SensorDataPage
                ),
                // Other buttons can be added here for navigation
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccelerometerPage(),
                      ),
                    );
                  },
                  child: Text('Accelerometer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GyroscopePage(),
                      ),
                    );
                  },
                  child: Text('Gyroscope'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MagnetometerPage(),
                      ),
                    );
                  },
                  child: Text('Magnetometer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrientationPage(),
                      ),
                    );
                  },
                  child: Text('Orientation (Roll, Pitch, Yaw)'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SensorDataPage()),
                    );
                  },
                  child: Text('Data'), // Navigates to SensorDataPage
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
