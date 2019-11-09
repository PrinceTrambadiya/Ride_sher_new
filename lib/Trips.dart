import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Trip_booked.dart';

class Trips extends StatefulWidget {
  @override
  _TripsState createState() => _TripsState();
}
String _uname = '';
var data1, data2, data3;
bool isProcess1 = true;
bool isProcess2 = true;
bool isProcess3 = true;

var progressIndicator = Container(
  child: Center(
    child: CircularProgressIndicator(),
  ),
);


class _TripsState extends State<Trips> {

  var mobile='',ststus1=0,ststus2=1,ststus3=2;

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
      addData1(mobile,ststus1.toString());
      addData2(mobile,ststus2.toString());
      addData3(mobile,ststus3.toString());
    } else {
      print('nathi aayo number');
    }
  }

  Future<void> addData1(mobile,ststus1) async {
    final response = await http
        .post("https://ridesher.000webhostapp.com/Fatch_Panding_trips.php", body: {
      "mobile": mobile,
      "ststus": ststus1,
    });

    setState(() {
      data1 = json.decode(response.body);
      List data11 = data1;
      //print(data11);
      if (data11.isEmpty)
        {
          setState(() {
            isProcess1 = true;
          });
        }
      else
        {
          setState(() {
            isProcess1 = false;
          });
        }
    });
  }

  Future<void> addData2(mobile,ststus2) async {
    final response = await http
        .post("https://ridesher.000webhostapp.com/Fatch_Panding_trips.php", body: {
      "mobile": mobile,
      "ststus": ststus2,
    });

    setState(() {
      data2 = json.decode(response.body);
      List data22 = data2;
      //print(data22);
      if (data22.isEmpty)
      {
        setState(() {
          isProcess2 = true;
        });
      }
      else
      {
        setState(() {
          isProcess2 = false;
        });
      }
    });
  }

  Future<void> addData3(mobile,ststus3) async {
    final response = await http
        .post("https://ridesher.000webhostapp.com/Fatch_Panding_trips.php", body: {
      "mobile": mobile,
      "ststus": ststus3,
    });

    setState(() {
      data3 = json.decode(response.body);
      List data33 = data3;
      //print(data5);
      if (data33.isEmpty)
      {
        setState(() {
          isProcess3 = true;
        });
      }
      else
      {
        setState(() {
          isProcess3 = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    var panding_body = ListView.builder(
        itemCount: data1 == null ? 0 : data1.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
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
                    )
                ),
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
                  )
              ),
            ),
          );
        });

    var complate_body = ListView.builder(
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
                  )
              ),
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
              body: isProcess1 ? progressIndicator : panding_body
            ),
            Scaffold(
              body: isProcess2 ? progressIndicator : running_body
            ),
            Scaffold(
              body: isProcess3 ? progressIndicator : complate_body
            ),
            Scaffold(
              body: progressIndicator,
            ),
          ],
        ),
      ),
    );
  }
}
