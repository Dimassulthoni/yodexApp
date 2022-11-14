import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yodex/database/databaselist.dart';
import 'package:yodex/list.dart';
import 'package:yodex/model/pengeluaran.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yodex APP',
      home: Splashscreen(),
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(156, 87, 13, 184))),
              labelStyle: TextStyle(color: Color.fromARGB(156, 87, 13, 184))),
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color.fromARGB(156, 87, 13, 184))),
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
          Image.asset(
            'images/wallet.png',
            scale: 2,
          ),
          const Text(
            'Your Daily Expends',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          )
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: const HomepageWidget(),
      splashIconSize: 250,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}

class HomepageWidget extends StatefulWidget {
  //final pengeluaran? list;
  const HomepageWidget({Key? key}) : super(key: key);
  @override
  _HomepageWidgetState createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  DatabaseInstance? databaseInstance;
  DatabaseInstance database = DatabaseInstance();
  String formattedDate =
      DateFormat('HH:mm E, d MMM yyyy').format(DateTime.now());
  String batas = 'masukan limit pengeluaran';
  int intBatas = 0;
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  Future<String> getUserData() async {
    final SharedPreferences sp = await _pref;
    limit.text = sp.getString('limit')!;
    return limit.text;
  }

  Future updateSP() async {
    final SharedPreferences sp = await _pref;
    sp.setString('limit', limit.text);
  }

  changeText() async {
    int? intBatas = int.tryParse(limit.text);
    int stotal = await database.totalPemasukan();
    // int total = int.parse(stotal);
    print("$stotal");
    print(stotal);
    print(intBatas);
    if (intBatas! > stotal) {
      setState(() {
        batas = "aman";
      });
    }
    if (intBatas == stotal) {
      setState(() {
        batas = "pengeluaran telah mencapai limit";
      });
    }
    if (intBatas < stotal) {
      setState(() {
        batas = "pengeluaran telah melebihi limit";
      });
    }
  }

  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    getUserData();
    changeText();
    setState(() {});
    database.database();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final limit = TextEditingController();

  int _value = 1;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller1.clear();
    controller2.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator HomepageWidget - COMPONENT
    setState(() {});
    return Scaffold(
        //background
        backgroundColor: Color.fromARGB(156, 87, 13, 184),
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Padding(
              // group 1
              padding: EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  Container(
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(156, 81, 3, 184))))),
                  Container(
                      padding: EdgeInsets.only(left: 120),
                      child: IconButton(
                        onPressed: () {
                          Alert(
                            context: context,
                            title: "Transaksi baru",
                            content: Column(
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.move_to_inbox_rounded,
                                      color: Color.fromARGB(156, 87, 13, 184),
                                    ),
                                    labelText: 'Nama',
                                  ),
                                  controller: controller1,
                                ),
                                TextField(
                                  //obscureText: true,
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    icon: Text(
                                      ' Rp',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(156, 87, 13, 184),
                                          fontSize: 15),
                                    ),
                                    labelText: 'Harga',
                                  ),
                                  controller: controller2,
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                onPressed: () async {
                                  int idInsert = await database.insert({
                                    'name': controller1.text,
                                    'type': _value,
                                    'total': controller2.text,
                                    'created_at': formattedDate,
                                    'updated_at': formattedDate,
                                  });
                                  print("sudah masuk : " + idInsert.toString());
                                  Navigator.pop(context);
                                  setState(() {
                                    controller1.clear();
                                    controller2.clear();
                                  });
                                  changeText();
                                },
                                color: const Color.fromRGBO(50, 168, 82, 10),
                                child: const Text(
                                  "SIMPAN",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                          ).show();
                        },
                        icon: Icon(
                          color: Colors.grey,
                          Icons.add,
                          fill: 1,
                        ),
                      ))
                ],
              )),
          Padding(
            //title
            padding: EdgeInsets.only(top: 119),

            child: FutureBuilder(
                future: databaseInstance!.totalPemasukan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("-");
                  } else {
                    if (snapshot.hasData) {
                      String totall = snapshot.data.toString();
                      return Container(
                        alignment: AlignmentDirectional.center,
                        child: Text("Rp. $totall",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.averiaSansLibre(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 48,
                                fontWeight: FontWeight.normal)),
                      );
                    } else {
                      return Text("0",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.averiaSansLibre(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 48,
                              fontWeight: FontWeight.normal));
                    }
                  }
                }),
          ),
          Padding(
              //backdrop
              padding: EdgeInsets.only(top: 260),
              child: Center(
                child: Container(
                    padding: EdgeInsets.only(top: 10),
                    constraints: BoxConstraints(minHeight: 460, minWidth: 400),
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
                                      child: Icon(
                                          Icons.account_balance_wallet_outlined,
                                          size: 50,
                                          color: Color.fromARGB(
                                              156, 87, 13, 184))),
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'status pengeluaran',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.averiaSansLibre(
                                    color: HexColor("2D0C57"), fontSize: 34),
                              )),
                          Container(
                              padding: EdgeInsets.all(20), child: Text(batas)),
                          const SizedBox(
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
                                  Alert(
                                    context: context,
                                    title: "Batasi Pengeluaran",
                                    content: Column(
                                      children: <Widget>[
                                        TextField(
                                          //obscureText: true,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            icon: Text(
                                              ' Rp',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      156, 87, 13, 184),
                                                  fontSize: 15),
                                            ),
                                            labelText: 'Limit',
                                          ),
                                          controller: limit,
                                        ),
                                      ],
                                    ),
                                    buttons: [
                                      DialogButton(
                                        onPressed: () {
                                          updateSP();
                                          changeText();
                                          Navigator.pop(context);
                                        },
                                        color: const Color.fromRGBO(
                                            50, 168, 82, 10),
                                        child: const Text(
                                          "SIMPAN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ).show();
                                },
                                child: const Text('Masukan limit',
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const listPage()));
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
        ])));
  }
}
