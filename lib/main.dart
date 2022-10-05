import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'total.dart';
import 'form.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return Scaffold(
        //background
        backgroundColor: Color.fromARGB(156, 87, 13, 184),
        body: Stack(children: <Widget>[
          Padding(
              // group 1
              padding: EdgeInsets.only(top: 40),
              child: Container(
                  width: 237,
                  height: 41,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(43),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(43),
                    ),
                    color: Color.fromRGBO(204, 255, 181, 1),
                  ),
                  child: Center(
                      child: Text('Your daily expenses',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.averiaSansLibre(
                              fontSize: 20, fontWeight: FontWeight.normal))))),
          Padding(
              //title
              padding: EdgeInsets.only(top: 119, left: 30),
              child: Text(
                'pengeluaran hari ini',
                textAlign: TextAlign.center,
                style: GoogleFonts.averiaSansLibre(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 48,
                    fontWeight: FontWeight.normal),
              )),
          Padding(
              //backdrop
              padding: EdgeInsets.only(top: 260),
              child: Center(
                child: Container(
                    padding: EdgeInsets.only(top: 10),
                    constraints: BoxConstraints(minHeight: 50, minWidth: 380),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 243, 243, 243),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Container(
                                width: 104,
                                height: 104,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(104, 104)),
                                ),
                                child: Center(
                                  child: Positioned(
                                      top: 0,
                                      left: 2.43157958984375,
                                      child: Image.asset('images/vector.png')),
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'status pengeluaran',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.averiaSansLibre(
                                    color: Color.fromARGB(156, 87, 13, 184),
                                    fontSize: 34),
                              )),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text('deskripsi status keuangan'),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          SizedBox(
                              width: 340,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(50, 168, 82, 10),
                                    elevation: 3,
                                    padding: EdgeInsets.only(top: 4)),
                                onPressed: () {
                                  //buka form
                                },
                                child: const Text('masukan pengeluaran',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    )),
                              )),
                          SizedBox(
                            width: 340,
                            height: 56,
                            child: TextButton(
                                onPressed: () {
                                  //buka rincian
                                },
                                child: const Text(
                                  'Rincian',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 131, 131, 131)),
                                )),
                          )
                        ])),
              )),
        ]));
  }
}
