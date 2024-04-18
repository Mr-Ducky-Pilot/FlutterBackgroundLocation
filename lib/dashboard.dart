import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'location_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'location_service.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final LocationService _locationService = LocationService();
  String _locationLog = '';

  void _startLocationUpdates() async {
    // await requestPermissions();
    await _locationService.startService();
    FlutterBackgroundService().on('update').listen((event) {
      if (event!['lat'] != null && event['lng'] != null) {
        setState(() {
          _locationLog += 'Location: ${event['lat']}, ${event['lng']}\n';
        });
      }
    });
  }

  // Future<void> requestPermissions() async {
  //   await Permission.location.request();
  //   await Permission.locationAlways.request();
  //   await Permission.locationWhenInUse.request();
  //   await Permission.scheduleExactAlarm.request();
  // }

  // void _stopLocationUpdates() {
  //   // FlutterBackgroundService().invoke('stopService');
  //   LocationService().stopService();
  // }

  void _stopLocationUpdates() {
    LocationService().stopService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _startLocationUpdates,
            child: Text('Start Live Location'),
          ),
          ElevatedButton(
            onPressed: _stopLocationUpdates,
            child: Text('Stop Live Location'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(_locationLog),
            ),
          ),
        ],
      ),
    );
  }
}
