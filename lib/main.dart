import 'package:bezel/src/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() async {
  await setup();
  runApp(const BezelApp());
}

Future<void> setup() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // .env file not found, will use token from Info.plist (iOS) or AndroidManifest (Android)
    print(
      "Warning: .env file not found. Using token from platform configuration.",
    );
  }

  // Try to get token from .env, but don't crash if it's not there
  // iOS will use MBXAccessToken from Info.plist, Android will use it from AndroidManifest
  final token = dotenv.env['MAPBOX_ACCESS_TOKEN'];
  if (token != null && token.isNotEmpty) {
    MapboxOptions.setAccessToken(token);
  }
}

class BezelApp extends StatelessWidget {
  const BezelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bezel',
      debugShowCheckedModeBanner: false, // Removes the red "Debug" banner
      theme: ThemeData(
        // Use Light Mode for a clean, white aesthetic
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
        // Set Scaffold background to transparent so the map isn't covered by white paint
        scaffoldBackgroundColor: Colors.transparent,
      ),
      // Set MapScreen as the home page
      home: const MapScreen(),
    );
  }
}
