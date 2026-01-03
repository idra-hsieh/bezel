import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mb;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  mb.MapboxMap? mapboxMapController;

  StreamSubscription? userPositionStream;

  @override
  void initState() {
    super.initState();
    _setupPositionTracking();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mb.MapWidget(
        onMapCreated: _onMapCreated,
        styleUri: mb.MapboxStyles.LIGHT,
      ),
    );
  }

  void _onMapCreated(mb.MapboxMap controller) {
    setState(() {
      mapboxMapController = controller;
    });

    mapboxMapController?.location.updateSettings(
      mb.LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
  }

  Future<void> _setupPositionTracking() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied forever.');
    }

    gl.LocationSettings locationSettings = gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 100,
    );

    userPositionStream?.cancel();
    userPositionStream =
        gl.Geolocator.getPositionStream(
          locationSettings: locationSettings,
        ).listen((gl.Position? position) {
          if (position != null && mapboxMapController != null) {
            mapboxMapController?.setCamera(
              mb.CameraOptions(
                zoom: 15,
                center: mb.Point(
                  coordinates: mb.Position(
                    position.longitude,
                    position.latitude,
                  ),
                ),
              ),
            );
          }
        });
  }
}
