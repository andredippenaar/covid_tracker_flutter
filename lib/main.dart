import 'package:covidtrackerflutter/datasource.dart';
import 'package:covidtrackerflutter/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Circular",
          primaryColor: primaryBlack,
          brightness: Brightness.light),
      home: HomePage(),
    );
  }
}
