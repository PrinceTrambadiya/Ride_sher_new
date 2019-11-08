import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trips extends StatefulWidget {
  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text('Trips'),
          bottom: TabBar(isScrollable: true, tabs: <Widget>[
            Tab(
              child: Text('   Panding      ',style: TextStyle(fontSize: 17),),
            ),
            Tab(
              child: Text('Running      ',style: TextStyle(fontSize: 17),),
            ),
            Tab(
              child: Text('Complate      ',style: TextStyle(fontSize: 17),),
            ), Tab(
              child: Text('Booked      ',style: TextStyle(fontSize: 17),),
            ),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            Scaffold(
              body: Container(),
            ),
            Scaffold(
              body: Container(),
            ),
            Scaffold(
              body: Container(),
            ),
            Scaffold(
              body: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
