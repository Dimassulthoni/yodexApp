import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'total.dart';
import 'form.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splashscreen(),
    );
  }
}

class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('images/digitalent.png'),
          const Text(
            'Your Daily Expends',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          )
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: HomepageWidget(),
      splashIconSize: 250,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}

class HomepageWidget extends StatefulWidget {
  @override
  _HomepageWidgetState createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator HomepageWidget - COMPONENT

    return Container(
        width: 414,
        height: 896,
        child: Stack(children: <Widget>[
          Positioned(
              top: -251,
              left: -194.99989318847656,
              child: Container(
                  width: 1031.9998779296875,
                  height: 975.7977905273438,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 498.0648498535156,
                        child: Transform.rotate(
                            angle: -41.570921194640036 * (math.pi / 180),
                            child: Image.asset('assets/images/ellipse8.svg',
                                semanticsLabel: 'ellipse8'))),
                    Positioned(
                        top: 130,
                        left: 279.9999084472656,
                        child: SvgPicture.asset('assets/images/ellipse9.svg',
                            semanticsLabel: 'ellipse9')),
                    Positioned(
                        top: 107,
                        left: 415.9999084472656,
                        child: SvgPicture.asset('assets/images/ellipse10.svg',
                            semanticsLabel: 'ellipse10')),
                    Positioned(
                        top: 82,
                        left: 482.9999084472656,
                        child: SvgPicture.asset('assets/images/ellipse12.svg',
                            semanticsLabel: 'ellipse12')),
                  ]))),
          Positioned(
              top: 312,
              left: 0,
              child: Container(
                  width: 414,
                  height: 584,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: SvgPicture.asset(
                            'assets/images/backdropbase.svg',
                            semanticsLabel: 'backdropbase')),
                    Positioned(
                        top: 297,
                        left: 21,
                        child: Text(
                          'Deskripsi status keuangan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(149, 134, 168, 1),
                              fontFamily: 'Arya',
                              fontSize: 17,
                              letterSpacing: -0.4099999964237213,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                    Positioned(
                        top: 192,
                        left: 44,
                        child: Text(
                          'Status Keuangan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(45, 12, 87, 1),
                              fontFamily: 'Averia Sans Libre',
                              fontSize: 34,
                              letterSpacing: 0.4099999964237213,
                              fontWeight: FontWeight.normal,
                              height: 1.2058823529411764),
                        )),
                    Positioned(
                        top: 64,
                        left: 157,
                        child: Container(
                            width: 104,
                            height: 104,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 104,
                                      height: 104,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(104, 104)),
                                      ))),
                              Positioned(
                                  top: 32,
                                  left: 32,
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 2.43157958984375,
                                            child: SvgPicture.asset(
                                                'assets/images/vector.svg',
                                                semanticsLabel: 'vector')),
                                      ]))),
                            ])))
                    // ),Positioned(
                    // top: 512,
                    //left: 174,
                    //child: null
                    //),Positioned(
                    //top: 424,
                    //left: 20,
                    //child: null
                    //),
                  ]))),
          Positioned(
              top: 134,
              left: 37,
              child: Text(
                'Rp. 1.000.000',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Averia Sans Libre',
                    fontSize: 48,
                    letterSpacing: 0.4099999964237213,
                    fontWeight: FontWeight.normal,
                    height: 0.8541666666666666),
              )),
          Positioned(
              top: 44,
              left: -16,
              child: Container(
                  width: 237,
                  height: 41,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 237,
                            height: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(43),
                                topRight: Radius.circular(43),
                                bottomLeft: Radius.circular(43),
                                bottomRight: Radius.circular(43),
                              ),
                              color: Color.fromRGBO(204, 255, 181, 1),
                            ))),
                    Positioned(
                        top: 8.31884765625,
                        left: 21.178722381591797,
                        child: Text(
                          'Your daily expenses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(111, 18, 231, 1),
                              fontFamily: 'Averia Sans Libre',
                              fontSize: 20,
                              letterSpacing: 0.4099999964237213,
                              fontWeight: FontWeight.normal,
                              height: 2.05),
                        )),
                  ]))),
        ]));
  }
}
