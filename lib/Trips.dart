import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Trip_booked.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Trips extends StatefulWidget {
  @override
  _TripsState createState() => _TripsState();
}

String _uname = '';
var data1, data2, data3, data4;
bool isProcess1 = true;
bool isProcess2 = true;
bool isProcess3 = true;
bool isProcess4 = true;

var progressIndicator = Container(
  child: Center(
    child: CircularProgressIndicator(),
  ),
);

class _TripsState extends State<Trips> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  var mobile = '', ststus1 = 0, ststus2 = 1, ststus3 = 2;

  @override
  void initState() {
    // TODO: implement initState
    _getPrefrence();
    super.initState();
  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    mobile = _uname.toString();
    //print(mobile);
    if (mobile != "") {
      // print('add');
      // print(mobile);
      addData1(mobile, ststus1.toString());
      addData2(mobile, ststus2.toString());
      addData3(mobile, ststus3.toString());
      addData4(mobile);
    } else {
      print('nathi aayo number');
    }
  }

  Future<void> addData1(mobile, ststus1) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Fatch_Panding_trips.php",
        body: {
          "mobile": mobile,
          "ststus": ststus1,
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

  Future<void> addData2(mobile, ststus2) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Fatch_Panding_trips.php",
        body: {
          "mobile": mobile,
          "ststus": ststus2,
        });

    setState(() {
      data2 = json.decode(response.body);
      List data22 = data2;
      //print(data22);
      if (data22.isEmpty) {
        setState(() {
          isProcess2 = true;
        });
      } else {
        setState(() {
          isProcess2 = false;
        });
      }
    });
  }

  Future<void> addData3(mobile, ststus3) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Fatch_Panding_trips.php",
        body: {
          "mobile": mobile,
          "ststus": ststus3,
        });

    setState(() {
      data3 = json.decode(response.body);
      List data33 = data3;
      //print(data5);
      if (data33.isEmpty) {
        setState(() {
          isProcess3 = true;
        });
      } else {
        setState(() {
          isProcess3 = false;
        });
      }
    });
  }

  Future<void> addData4(mobile) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Fatch_myBookd_trips.php",
        body: {
          "mobile": mobile,
        });

    setState(() {
      data4 = json.decode(response.body);
      List data44 = data4;
      print(data44);
      if (data44.isEmpty) {
        setState(() {
          isProcess4 = true;
        });
      } else {
        setState(() {
          isProcess4 = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pending_body = ListView.builder(
        itemCount: data1 == null ? 0 : data1.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
//                print(index);
//                print('Tap');
//                print(data1[index]['ride_id']);
                var ride_id = data1[index]['ride_id'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Trip_booked(ride_id)));
              });
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Text(data1[index]['start_point']),
                    Text(data1[index]['end_point']),
                    Text(data1[index]['pick_up']),
                    Text(data1[index]['seats_available']),
                    Text(data1[index]['cost']),
                    Text(data1[index]['start_date']),
                    Text(data1[index]['start_time']),
                  ],
                )),
              ),
            ),
          );
        });

    var running_body = ListView.builder(
        itemCount: data2 == null ? 0 : data2.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Text(data2[index]['start_point']),
                  Text(data2[index]['end_point']),
                  Text(data2[index]['pick_up']),
                  Text(data2[index]['seats_available']),
                  Text(data2[index]['cost']),
                  Text(data2[index]['start_date']),
                  Text(data2[index]['start_time']),
                ],
              )),
            ),
          );
        });

    var complete_body = ListView.builder(
        itemCount: data3 == null ? 0 : data3.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Text(data3[index]['start_point']),
                  Text(data3[index]['end_point']),
                  Text(data3[index]['pick_up']),
                  Text(data3[index]['seats_available']),
                  Text(data3[index]['cost']),
                  Text(data3[index]['start_date']),
                  Text(data3[index]['start_time']),
                ],
              )),
            ),
          );
        });

    var booked_body = ListView.builder(
        itemCount: data4 == null ? 0 : data4.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Text(data4[index]['start_point']),
                  Text(data4[index]['end_point']),
                  Text(data4[index]['pick_up']),
                  Text(data4[index]['cost']),
                  Text(data4[index]['driver_mobile']),
                  Text(data4[index]['start_date']),
                  Text(data4[index]['start_time']),
                ],
              )),
            ),
          );
        });

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text('Trips'),
          bottom: TabBar(isScrollable: true, tabs: <Widget>[
            Tab(
              child: Text(
                '   Pending      ',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Tab(
              child: Text(
                'Running      ',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Tab(
              child: Text(
                'Complete      ',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Tab(
              child: Text(
                'Booked      ',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            Scaffold(
                body: SmartRefresher(
                    enablePullDown: true,
                    header: WaterDropHeader(
                      waterDropColor: Colors.indigoAccent,
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: isProcess1 ? progressIndicator : pending_body)),
            Scaffold(
                body: SmartRefresher(
                    enablePullDown: true,
                    header: WaterDropHeader(
                      waterDropColor: Colors.indigoAccent,
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: isProcess2 ? progressIndicator : running_body)),
            Scaffold(
                body: SmartRefresher(
                    enablePullDown: true,
                    header: WaterDropHeader(
                      waterDropColor: Colors.indigoAccent,
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: isProcess3 ? progressIndicator : complete_body)),
            Scaffold(
                body: SmartRefresher(
                    enablePullDown: true,
                    header: WaterDropHeader(
                      waterDropColor: Colors.indigoAccent,
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: isProcess4 ? progressIndicator : booked_body)),
          ],
        ),
      ),
    );
  }
}
