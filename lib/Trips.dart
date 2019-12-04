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
var data1, data2, data3, data4, data5;
List data55 = [];
List data44 = [];
bool isProcess1 = true;
bool isProcess2 = true;
bool isProcess3 = true;
bool isProcess4 = true;
bool isEnable = true;

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
    _getPrefrence();
    _refreshController.refreshCompleted();
  }

  var mobile = '', ststus1 = 0, ststus2 = 1, ststus3 = 2,finalRideId= '';
  bool isButtonEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    _getPrefrence();
    super.initState();
  }

  void start_trip(){



  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    mobile = _uname.toString();
    //print(mobile);
    if (mobile != "") {
      // print('add');
      // print(mobile);
      addData4(mobile);
      addData1(mobile, ststus1.toString());
      addData2(mobile, ststus2.toString());
      addData3(mobile, ststus3.toString());

      addData5(mobile);
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
    List data22 = [];
//    for(int i = 0 ; i<=data44.length-1 ; i++) {
//      print(data4[i]['driver_mobile'].toString());
//    }
//
//    final response = await http.post(
//        "https://ridesher.000webhostapp.com/Fatch_Panding_trips.php",
//        body: {
//          "mobile": mobile,
//          "ststus": ststus2,
//        });
//    data2 = json.decode(response.body);
//    data22.add(data2);
    print( data44[0]['ride_id'].toString());

    for(int i = 0 ; i<=data44.length-1 ; i++) {
      print('hellocncnsk&&&&&&&!!!!!!!!!!!');
      var ride_id_final = data44[i]['ride_id'].toString();
      final response2 = await http.post(
          "https://ridesher.000webhostapp.com/Fatch_running_trips.php",
          body: {
            "mobile": mobile.toString(),
            "ride_id": ride_id_final.toString(),
            "ststus": ststus2,
          });
      data2 = json.decode(response2.body);
      data22 = data2;
    }


    setState(() {
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
    List data33 =[];

    for(int i = 0 ; i<=data44.length-1 ; i++) {
      print('hellocncnsk&&&&&&&!!!!!!!!!!!');
      var ride_id_final = data44[i]['ride_id'].toString();
      final response = await http.post(
          "https://ridesher.000webhostapp.com/Fatch_running_trips.php",
          body: {
            "mobile": mobile.toString(),
            "ride_id": ride_id_final.toString(),
            "ststus": ststus3,
          });
      data3 = json.decode(response.body);
      data33 = data3; }
    setState(() {
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
      data44 = data4;
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


  Future<void> addData5(mobile) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Fatch_Bookd_trips - status.php",
        body: {
          "mobile": mobile,
        });

    setState(() {
      data5 = json.decode(response.body);
      data55 = data5;
      print(data55);
    });
  }
  Future<void> addData6(ride_id,mobile) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Update_trip_booked_ststus 2.php",
        body: {
          "ride_id": ride_id,
          "mobile": mobile.toString(),
        });
    setState(() {
      setState(() {
        isEnable = true;
      });
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Card(color: Colors.blue.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(color: Colors.blue.shade100,
                      child: Column(
                    children: <Widget>[
                      Text('Start Point : '+data1[index]['start_point']),
                      Text('End Point : '+data1[index]['end_point']),
                      Text('Pick Up : '+data1[index]['pick_up']),
                      Text('Seats Available : '+data1[index]['seats_available']),
                      Text('Cost : '+data1[index]['cost']),
                      Text('Start Date : '+data1[index]['start_date']),
                      Text('Start Time : '+data1[index]['start_time']),
                    ],
                  )),
                ),
              ),
            ),
          );
        });

    var running_body = ListView.builder(
        itemCount: data2 == null ? 0 : data2.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Card(color: Colors.green.shade100,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Text('Start Point : '+data2[index]['start_point']),
                    Text('End Point : '+data2[index]['end_point']),
                    Text('Pick Up : '+data2[index]['pick_up']),
                    Text('Seats Available : '+data2[index]['seats_available']),
                    Text('Cost : '+data2[index]['cost']),
                    Text('Start Date : '+data2[index]['start_date']),
                    Text('Start Time : '+data2[index]['start_time']),
                  ],
                )),
              ),
            ),
          );
        });

    var complete_body = ListView.builder(
        itemCount: data3 == null ? 0 : data3.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Card(color: Colors.yellow.shade100,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Text('Start Time : '+data3[index]['start_point']),
                    Text('End Point  : '+data3[index]['end_point']),
                    Text('Pick Up : '+data3[index]['pick_up']),
                    Text('Seats Available : '+data3[index]['seats_available']),
                    Text('Cost : '+data3[index]['cost']),
                    Text('Start Date : '+data3[index]['start_date']),
                    Text('Start Time : '+data3[index]['start_time']),
                  ],
                )),
              ),
            ),
          );
        });

    var booked_body = ListView.builder(
        itemCount: data4 == null ? 0 : data4.length,
        itemBuilder: (BuildContext context, int index) {

//          setState(() {
          if(data55[index]['ststus'].toString()== '1'){
            isEnable = false;
          }
          else{
            isEnable = true;
          }
//          });
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Card(color: Colors.red.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(

                      child: Column(
                    children: <Widget>[
                      Text('Start Point : '+data4[index]['start_point']),
                      Text('End Point : '+data4[index]['end_point']),
                      Text('Pick Up : '+data4[index]['pick_up']),
                      Text('Cost : '+data4[index]['cost']),
                      Text('Driver Mobile : '+data4[index]['driver_mobile']),
                      Text('Start Date : '+data4[index]['start_date']),
                      Text('Start Time : '+data4[index]['start_time']),
                      MaterialButton(
                       onPressed: isEnable ? null : () {
                         setState(() {
                           addData6(data4[index]['ride_id'].toString(),data4[index]['mobile'].toString());
                         });
                       },
                        child: Text('CONFIRM'),
                        color: Colors.amberAccent,
                      ),

                    ],
                  )),
                ),
              ),
            ),
          );
        });

    return DefaultTabController(
      length: 4,
      child: Scaffold(backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
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
