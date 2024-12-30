import 'package:flutter/material.dart';
import 'package:my_tube/views/screens/tab_screen.dart';
import 'package:y_player/y_player.dart';

void main() async {
  YPlayerInitializer.ensureInitialized();

  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures all bindings are initialized.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Videos',
      home: TabScreen(),
    );
  }
}
