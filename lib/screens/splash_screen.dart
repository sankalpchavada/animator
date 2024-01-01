import 'dart:async';

import 'package:animator_app/screens/homepage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationcontroller;

  @override
  void initState() {
    // TODO: implement initState

    animationcontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..forward();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        _createRoute(),
      );
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutBack;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Image.asset("assets/images/splash_image.jpg",
                fit: BoxFit.fitHeight),
          ),
          Align(
              alignment: FractionalOffset.bottomLeft,
              child: FadeTransition(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Animator",
                          style: TextStyle(fontSize: 55),
                        ),
                        Text(
                          "Explore The Universe",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  opacity: animationcontroller)),
        ],
      ),
    );
  }
}
