import 'package:flutter/material.dart';
import 'package:my_tube/views/screens/tab_screen.dart';

void main() async {
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
