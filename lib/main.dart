import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polyline Delay Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const GMapPage(),
    );
  }
}

class GMapPage extends StatefulWidget {
  const GMapPage({Key? key}) : super(key: key);

  @override
  State<GMapPage> createState() => _GMapPageState();
}

class _GMapPageState extends State<GMapPage> {
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  List<Polyline> selectedRoutes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            polylines: selectedRoutes.toSet(),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              color: selectedRoutes.isEmpty ? Colors.green : Colors.red,
              child: Text(
                  "Polyline is ${selectedRoutes.isEmpty ? "removed" : "added"}"),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            if (selectedRoutes.isNotEmpty) {
              selectedRoutes.clear();
            } else {
              selectedRoutes.add(
                const Polyline(
                  polylineId: PolylineId("polyline"),
                  width: 15,
                  color: Colors.red,
                  points: [
                    LatLng(37.383702829, -121.849590592),
                    LatLng(37.43296265331129, -122.08832357078792),
                    LatLng(37.4635247785, -122.344907384),
                  ],
                ),
              );
            }
          });
        },
        label: const Text('toggle polylines'),
        icon: const Icon(Icons.stacked_line_chart_sharp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
