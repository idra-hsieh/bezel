import 'package:flutter/material.dart';
import 'src/screens/map_screen.dart'; // Import the MapScreen

void main() {
  runApp(const BezelApp());
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
