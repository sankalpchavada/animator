import 'dart:math';

import 'package:flutter/material.dart';

import '../models/planet_model.dart';

class InfoPage extends StatefulWidget {
  InfoPage({super.key, required this.planets});

  Planets planets;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  static late AnimationController TheanimationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    TheanimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: TheanimationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: TheanimationController.value * 2 * pi,
                  child: Container(
                    child: Image.network(
                      widget.planets.image,
                      alignment: Alignment.topRight,
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 6),
                              child: Text(
                                widget.planets.name,
                                style: const TextStyle(
                                    letterSpacing: 5,
                                    fontSize: 52,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.planets.position,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: const Text(
                              "Velocity",
                              style: TextStyle(fontSize: 20, letterSpacing: 2),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${widget.planets.velocity} km/s",
                              style: TextStyle(fontSize: 20, letterSpacing: 2),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Distance",
                            style: TextStyle(fontSize: 20, letterSpacing: 2),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${widget.planets.distance}00000 km",
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 2),
                              ),
                              Text(
                                "from sun",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                strokeAlign: 1,
                                width: 2,
                                color: Colors.black38)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.planets.description,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (Navigator.canPop(context) == true) {
      TheanimationController.dispose();
    }
  }
}
