import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Payment_page.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


var data1;


var rideId,
    startPoint,
    endPoint,
    pickUp,
    seatsAvailable,
    cost,
    startDate,
    startTime,
    ststus,
    mobile,
    feedback = '0.0';

int seatSelected, availableStats, cost2;

class Book_trip extends StatefulWidget {
  Book_trip(
      String rideId1,
      String startPoint1,
      String endPoint1,
      String pickUp1,
      String seatsAvailable1,
      String cost1,
      String startDate1,
      String startTime1,
      String ststus1,
      String mobile1) {
    rideId = rideId1;
    startPoint = startPoint1;
    endPoint = endPoint1;
    pickUp = pickUp1;
    seatsAvailable = seatsAvailable1;
    cost = cost1;
    cost2 = int.parse(cost);
    startDate = startDate1;
    startTime = startTime1;
    ststus = ststus1;
    mobile = mobile1;
  }

  @override
  _Book_tripState createState() => _Book_tripState();
}

class Seats {
  int id;
  String name;

  Seats(this.id, this.name);

  static List<Seats> getselectedSeats() {
    return <Seats>[
      Seats(1, '1'),
      Seats(2, '2'),
      Seats(3, '3'),
      Seats(4, '4'),
      Seats(5, '5'),
      Seats(6, '6'),
      Seats(7, '7'),
    ];
  }
}

class _Book_tripState extends State<Book_trip> {
  List<Seats> _seats = Seats.getselectedSeats();
  List<DropdownMenuItem<Seats>> _dropDownMenuItams;
  Seats _selectedSeats;
  int oldcost = cost2, newCost;

  @override
  void initState() {
    // TODO: implement initState
    _dropDownMenuItams = buildDropDownMenuItms(_seats);
    _selectedSeats = _dropDownMenuItams[0].value;
    reating();
    super.initState();
  }

  List<DropdownMenuItem<Seats>> buildDropDownMenuItms(List seats) {
    List<DropdownMenuItem<Seats>> items = List();
    for (Seats seat in seats) {
      items.add(DropdownMenuItem(value: seat, child: Text(seat.name)));
    }
    return items;
  }

  onChangeDropDownMenuItem(Seats sealectedSeats)
  {
    setState(() {
      _selectedSeats = sealectedSeats;
    });
  }


    Future<void> reating() async {

      final response = await http.post(
          "https://ridesher.000webhostapp.com/Fatch_Feedback.php",
          body: {
            "driver_mobile": mobile.toString(),
          });
      setState(() {
        data1 = json.decode(response.body);
        List data11 = data1;
        print(data11);
        if (data11.isEmpty) {
          setState(() {
            feedback = 'No Rating';
          });
        } else {
          setState(() {
            feedback = data11[0]['total'];
          });
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    print(rideId);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrange,
        title: Text('Booking Page'),
      ),
      body: Container(color: Colors.blue.shade100,
        child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 50, 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Start Point : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(startPoint),
                          ],
                        ),
                        SizedBox(height: 7.0,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Destination Point : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(endPoint),
                          ],
                        ),
                        SizedBox(height: 7.0,),
                        Row(
                          children: <Widget>[
                            Text(
                              'PickUp Point : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(pickUp),
                          ],
                        ),
                        SizedBox(height: 7.0,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Seats Available : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(seatsAvailable),
                          ],
                        ),
                        SizedBox(height: 7.0,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Cost : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(cost+' ₹'),
                          ],
                        ),
                        SizedBox(height: 7.0,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Start Date : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(startDate),
                          ],
                        ),
                        SizedBox(height: 7.0,),
                        Row(
                          children: <Widget>[
                            Text(
                              'Start Time : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(startTime),
                          ],
                        ),
                        SizedBox(height: 7.0),
                        Row(
                          children: <Widget>[
                            Text(
                              'Rating : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(feedback),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.0,),
              Text('Select number of seats : ',style: TextStyle(fontWeight: FontWeight.bold),),
//            SizedBox(
//              height: 10.0,
//            ),
              DropdownButton(
                  value: _selectedSeats,
                  items: _dropDownMenuItams,
                  onChanged: onChangeDropDownMenuItem),
             // SizedBox(height: 10.0,),
            //  Text('Seats Selected : ${_selectedSeats.name}'),
              SizedBox(height: 20.0,),
              MaterialButton(
                onPressed: () {
                   seatSelected = int.parse(_selectedSeats.name.toString());
                   availableStats = int.parse(seatsAvailable.toString());
                   print(oldcost.toString());
                   newCost = oldcost * seatSelected;
                   print(newCost.toString());
                  setState(() {

                    if(seatSelected > availableStats)
                      {
                        setState(() {
                          Toast.show('Your selected seats is more than available seats.', context,
                              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
                        });
                      }

                    else
                      {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Payment_page(
                                      newCost.toString(),
                                      seatsAvailable,
                                      rideId,
                                      startPoint,
                                      endPoint,
                                      pickUp,
                                      mobile,
                                      startDate,
                                      startTime,
                                  seatSelected.toString())));
                        });
                      }

                  });
                },padding: EdgeInsets.fromLTRB(75, 15, 75, 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Text('Book',style: TextStyle(fontSize: 15),),
                color: Colors.amberAccent,
              )
            ],
          ),

      ),
    );
  }
}
