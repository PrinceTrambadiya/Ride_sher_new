import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Payment_page.dart';

var rideId,startPoint,endPoint,pickUp,seatsAvailable,cost,startDate,startTime,ststus,mobile;

class Book_trip extends StatefulWidget {
  Book_trip(String rideId1, String startPoint1, String endPoint1, String pickUp1, String seatsAvailable1, String cost1,
      String startDate1, String startTime1, String ststus1, String mobile1)
  {
    rideId = rideId1;
    startPoint = startPoint1;
    endPoint = endPoint1;
    pickUp = pickUp1;
    seatsAvailable = seatsAvailable1;
    cost = cost1;
    startDate = startDate1;
    startTime = startTime1;
    ststus = ststus1;
    mobile = mobile1;
  }

  @override
  _Book_tripState createState() => _Book_tripState();
}

class _Book_tripState extends State<Book_trip> {
  @override
  Widget build(BuildContext context) {
    print(rideId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Page'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Start Point : ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(startPoint),
              ],
            ),
            Row(
              children: <Widget>[
                Text('End Point : ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(endPoint),
              ],
            ),
            Row(
              children: <Widget>[
                Text('PickUp Point : ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(pickUp),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Seats Available : ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(seatsAvailable),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Cost : ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(cost),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Start Date : ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(startDate),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Start Time : ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(startTime),
              ],
            ),
            MaterialButton(onPressed: (){
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Payment_page(cost,seatsAvailable,rideId,startPoint,endPoint,pickUp,mobile,startDate,startTime)));
              });
            },child: Text('Book'),color: Colors.amberAccent,)
          ],
        ),
      ),
    );
  }
}
