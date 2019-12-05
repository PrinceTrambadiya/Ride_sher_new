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
    addData2(ride_id);
    _refreshController.refreshCompleted();
  }

  @override
  var ride_id = ride_id0;
  bool isProcess1 = true;
  bool sendConfirmation = true;
  bool startRide = false;

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
    data1 = json.decode(response.body);
    List data11 = data1;
      print(data11);
      for(int i = 0 ; i<=data11.length-1;i++)
        {
          print(data11[i]['ststus']);
          if(data11[i]['ststus'].toString()== '0'){
            setState(() {
              sendConfirmation = true;
              startRide = false;
            });
          }
          else if(data11[i]['ststus'].toString()== '2')
            {
              setState(() {
                sendConfirmation = false;
                startRide = true;
              });
            }
          else{
            setState(() {
              sendConfirmation = false;
              startRide = false;
              return;
            });

          }
        }
    setState(() {


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

  Future<void> addData2(ride_id) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Update_trip_booked_ststus.php",
        body: {
          "ride_id": ride_id,
        });
    setState(() {
      sendConfirmation = false;
    });
//    data1 = json.decode(response.body);
//    List data11 = data1;
//    print(data11);
//    for(int i = 0 ; i<=data11.length-1;i++)
//    {
//      print(data11[i]['ststus']);
//      if(data11[i]['ststus'].toString()== '0'){
//        setState(() {
//          sendConfirmation = true;
//          startRide = false;
//        });
//      }
//    }
//    setState(() {
//
//
//      if (data11.isEmpty) {
//        setState(() {
//          isProcess1 = true;
//        });
//      } else {
//        setState(() {
//          isProcess1 = false;
//        });
//      }
//    });
  }

  Future<void> addData3(ride_id) async {
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Update_trip_panding_ststus.php",
        body: {
          "ride_id": ride_id,
        });
  }

  Widget build(BuildContext context) {
    //print(ride_id);

    var booking_body = ListView.builder(
        itemCount: data1 == null ? 0 : data1.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Card(color: Colors.lightGreenAccent.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Name : ',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(data1[index]['name']),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Row(
                        children: <Widget>[
                          Text('Email : ',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(data1[index]['email']),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Row(
                        children: <Widget>[
                          Text('Seat Booked : ',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(data1[index]['seat_booked']),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Row(
                        children: <Widget>[
                          Text('Mobile : ',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(data1[index]['mobile']),
                        ],
                      ),
                      //Text(data1[index]['ststus']),
                    ],
                  )),
                ),
              ),
            ),
          );
        });

    return Scaffold(backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: Text('Booking Details'),

          backgroundColor: Colors.deepOrange,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrange,
          onPressed: bottomSheet,
          tooltip: 'Click',
        ),
        body: Container(
          child: SmartRefresher(
              enablePullDown: true,
              header: WaterDropHeader(
                waterDropColor: Colors.indigoAccent,
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: isProcess1 ? progressIndicator : booking_body),
        ));
  }
  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            //   color: Colors.red,
            height: 130,
            child: Container(
              decoration: BoxDecoration(
                //     color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30))),
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.send),
                      title: Text('Send Confirmation'),
                    onTap: (){
                        addData2(ride_id);
                        sendConfirmation = false;
                    },
                  enabled: sendConfirmation,),
                  ListTile(
                      leading: Icon(Icons.local_taxi),
                      title: Text('Start Ride'),
                     onTap: (){
                        setState(() {
                          addData3(ride_id);
                          startRide = false;
                        });
                     },
                  enabled: startRide,),
                ],
              ),
            ),
          );
        });
  }
}



