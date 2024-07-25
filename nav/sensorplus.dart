import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  String _gpsStatus = 'Unknown';
  GyroscopeEvent? _gyroscopeEvent;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _listenToGyroscope();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _gpsStatus = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        setState(() {
          _gpsStatus = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _gpsStatus = 'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _gpsStatus = 'Location: ${position.latitude}, ${position.longitude}';
    });
  }

  void _listenToGyroscope() {
    SensorsPlus.gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeEvent = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensors Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'GPS Status: $_gpsStatus',
              style: Theme.of(context).textTheme.headline6,
            ),
            if (_currentPosition != null)
              Text(
                'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            SizedBox(height: 20),
            Text(
              'Gyroscope Data:',
              style: Theme.of(context).textTheme.headline6,
            ),
            if (_gyroscopeEvent != null)
              Text(
                'X: ${_gyroscopeEvent!.x}, Y: ${_gyroscopeEvent!.y}, Z: ${_gyroscopeEvent!.z}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
          ],
        ),
      ),
    );
  }
}
