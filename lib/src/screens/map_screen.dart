import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
// Import your separated component
import '../widgets/glass_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // --- LAYER 1: The Background Map ---
          MapWidget(
            styleUri: "mapbox://styles/idra-hsieh/cmjryrvyu000101rd65odctc5",
            cameraOptions: CameraOptions(
              center: Point(coordinates: Position(121.5654, 25.0330)),
              zoom: 15.0,
            ),
            onMapCreated: (MapboxMap mapboxMap) {
              this.mapboxMap = mapboxMap;
            },
          ),

          // --- LAYER 2: Top Status Bar ---
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: GlassCard(
              height: 60,
              child: Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Text(
                    "Exploring: Xinyi District (test)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- LAYER 3: Bottom Control Panel ---
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassCard(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconBtn(Icons.map, "Map"),
                  _buildIconBtn(Icons.history, "Log"),
                  _buildIconBtn(Icons.settings, "Settings"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconBtn(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 28, color: Colors.black87),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
