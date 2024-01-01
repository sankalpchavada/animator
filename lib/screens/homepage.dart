import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:animator_app/models/planet_model.dart';
import 'package:animator_app/screens/infopage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Planets> fetchPlanets = [];

  PageController pageController = PageController();
  static late AnimationController TheanimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    TheanimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();

    Timer(
      const Duration(microseconds: 10),
      () => getJson().then((value) {
        setState(() {});
      }),
    );
  }

  Future<void> getJson() async {
    String data = await rootBundle.loadString('assets/json/planets.json');

    var res = jsonDecode(data);

    List planetList = res['planet'];

    fetchPlanets = planetList
        .map((e) => Planets(
            position: e['position'],
            name: e['name'],
            image: e['image'],
            distance: e['distance'],
            description: e['description'],
            velocity: e['velocity']))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Colors.black,

      body: BuildUI(),
    );
  }

  Widget BuildUI() {
    return SafeArea(
      child: PageView(
        physics: ClampingScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: fetchPlanets
            .map((e) => SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                        animation: TheanimationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: TheanimationController.value * 2 * pi,
                            child: SizedBox(
                              height: 700,
                              width: 400,
                              child: Image.network(
                                e.image,
                                alignment: Alignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onDoubleTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InfoPage(planets: e),
                                              ));
                                        },
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: Text(
                                            e.name,
                                            style: const TextStyle(
                                                letterSpacing: 5,
                                                fontSize: 52,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            e.position,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: const Text(
                                        "Velocity",
                                        style: TextStyle(
                                            fontSize: 20, letterSpacing: 2),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${e.velocity} km/s",
                                        style: TextStyle(
                                            fontSize: 20, letterSpacing: 2),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Distance",
                                      style: TextStyle(
                                          fontSize: 20, letterSpacing: 2),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${e.distance}00000 km",
                                          style: TextStyle(
                                              fontSize: 20, letterSpacing: 2),
                                        ),
                                        Text(
                                          "from sun",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
