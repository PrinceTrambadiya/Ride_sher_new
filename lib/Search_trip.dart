import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:convert';
import 'Book_trip.dart';
import 'package:shared_preferences/shared_preferences.dart';

var pickUp0, destination0, data1,gender0;
String _uname = '';

class Search_trip extends StatefulWidget {
  var pickUp1, destination1;
  Search_trip(String pickUp1, String destination1, String gender1) {
    this.pickUp1 = pickUp1;
    this.destination1 = destination1;
    pickUp0 = pickUp1;
    destination0 = destination1;
    gender0 = gender1;
  }

  @override
  _Search_tripState createState() => _Search_tripState();
}

class _Search_tripState extends State<Search_trip> {
  var pickUp = pickUp0, destination = destination0, seatsAvailable = 0;
  bool isProcess1 = true;
  var startPoint = '',
      endPoint = '',
      pickUpPoint = '',
      cost = '',
      seatsAvailable1 = '',
      startDate = '',
      startTime = '',
      rideId = '',
      ststus = '',
      mobile = '',
      userMobile = '',
      gender = gender0.toString();

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    userMobile = _uname.toString();
    print(userMobile);
    if (userMobile != "") {
      print('add');
       print('ZZZZZZ'+userMobile);
    } else {
      print('nathi aayo number');
    }
    addData1(pickUp, destination, seatsAvailable,userMobile,gender);
  }

  var progressIndicator = Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    addData1(pickUp, destination, seatsAvailable,userMobile,gender);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    _getPrefrence();
    super.initState();
  }

  Future<void> addData1(pickUp, destination, seatsAvailable, userMobile1,gender1) async {
//    print('ANDAR');
//    print(pickUp);
//    print(destination);
//    print(seatsAvailable);
  print('UUU'+userMobile+'   UUU');
    final response = await http.post(
        "https://ridesher.000webhostapp.com/Fatch_Search_trips.php",
        body: {
          "start_point": pickUp.toString(),
          "end_point": destination.toString(),
          "seats_available": seatsAvailable.toString(),
          "mobile": userMobile.toString(),
          "gender": gender.toString(),
        });
    setState(() {
      data1 = json.decode(response.body);
      List data11 = data1;
      print(data11);
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

  @override
  Widget build(BuildContext context) {
    var search_body = ListView.builder(
        itemCount: data1 == null ? 0 : data1.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                rideId = data1[index]['ride_id'];
                startPoint = data1[index]['start_point'];
                endPoint = data1[index]['end_point'];
                mobile = data1[index]['mobile'];
                pickUp = data1[index]['pick_up'];
                seatsAvailable1 = data1[index]['seats_available'];
                cost = data1[index]['cost'];
                startDate = data1[index]['start_date'];
                startTime = data1[index]['start_time'];
                ststus = data1[index]['ststus'];

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Book_trip(
                            rideId,
                            startPoint,
                            endPoint,
                            pickUp,
                            seatsAvailable1,
                            cost,
                            startDate,
                            startTime,
                            ststus,
                            mobile)));
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Card(color: Colors.pink.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Text('Start Point : '+data1[index]['start_point']),
                      Text('End Point : '+data1[index]['end_point']),
                      Text('Pick Up : '+data1[index]['pick_up']),
                      Text('Seats Available : '+data1[index]['seats_available']),
                      Text('Coat : '+data1[index]['cost']),
                      Text('Start Date : '+data1[index]['start_date']),
                      Text('Start Time : '+data1[index]['start_time']),
                    ],
                  )),
                ),
              ),
            ),
          );
        });
//    print(pickUp);
//    print(destination);
    return Scaffold(backgroundColor: Colors.blue.shade100,
        appBar: AppBar(backgroundColor: Colors.deepOrange,
          title: Text('Search Result'),
        ),
        body: SmartRefresher(
            enablePullDown: true,
            header: WaterDropHeader(
              waterDropColor: Colors.indigoAccent,
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: isProcess1 ? progressIndicator : search_body));
  }
}
