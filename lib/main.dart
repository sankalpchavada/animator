import 'package:animator_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AnimatorApp());
}

class AnimatorApp extends StatefulWidget {
  const AnimatorApp({super.key});

  @override
  State<AnimatorApp> createState() => _AnimatorAppState();
}

class _AnimatorAppState extends State<AnimatorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
