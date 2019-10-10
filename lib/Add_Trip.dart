import 'package:flutter/material.dart';

class Add_Trip extends StatefulWidget {
  @override
  _Add_TripState createState() => _Add_TripState();
}

class _Add_TripState extends State<Add_Trip> {
  TextEditingController cSits = new TextEditingController();
  TextEditingController cStartPoint = new TextEditingController();
  TextEditingController cEndPoint = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Trip'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Number Of Seats Available'),
            TextField(
              controller: cSits,
            ),
            Text('Starting Point'),
            TextField(
              controller: cStartPoint,
            ),
            Text('Ending Point'),
            TextField(
              controller: cEndPoint,
            ),
          ],
        ),
      ),
    );
  }
}
