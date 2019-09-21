import 'package:flutter/material.dart';
import 'package:map_demo/GoogleMap/home.dart';

class Map extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rideshare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'RideShare'),
    );
  }
}
