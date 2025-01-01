import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:my_tube/util/constant.dart';
import 'package:my_tube/util/theme.dart';
import 'package:my_tube/views/screens/tab_screen.dart';
import 'package:y_player/y_player.dart';

void main() async {
  YPlayerInitializer.ensureInitialized();

  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures all bindings are initialized.
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme(),
      title: 'YouTube Videos',
      home: TabScreen(),
    );
  }
}
