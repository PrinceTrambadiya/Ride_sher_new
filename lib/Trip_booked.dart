import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

var ride_id0 = '', data1;

class Trip_booked extends StatefulWidget {
  var ride_id1;

  Trip_booked(ride_id1) {
    this.ride_id1 = ride_id1;
    ride_id0 = ride_id1;
  }

  @override
  _Trip_bookedState createState() => _Trip_bookedState();
}

class _Trip_bookedState extends State<Trip_booked> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    addData1(ride_id);
    _refreshController.refreshCompleted();
  }

  @override
  var ride_id = ride_id0;
  bool isProcess1 = true;

  @override
  void initState() {
    // TODO: implement initState
    addData1(ride_id);
    super.initState();
  }

  var progressIndicator = Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  Future<void> addData1(ride_id) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Fatch_booked_trips.php",
        body: {
          "ride_id": ride_id,
        });

    setState(() {
      data1 = json.decode(response.body);
      List data11 = data1;
      //print(data11);
      if (data11.isEmpty) {
        setState(() {
          isProcess1 = true;
        });
      } else {
        setState(() {
          isProcess1 = false;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    //print(ride_id);

    var booking_body = ListView.builder(
        itemCount: data1 == null ? 0 : data1.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Text(data1[index]['name']),
                    Text(data1[index]['email']),
                    Text(data1[index]['mobile']),
                  ],
                )),
              ),
            ),
          );
        });

    return Scaffold(
        appBar: AppBar(
          title: Text('Booking Details'),
          backgroundColor: Colors.indigoAccent,
        ),
        body: SmartRefresher(
            enablePullDown: true,
            header: WaterDropHeader(
              waterDropColor: Colors.indigoAccent,
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: isProcess1 ? progressIndicator : booking_body));
  }
}
