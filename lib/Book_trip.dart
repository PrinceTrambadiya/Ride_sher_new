import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Payment_page.dart';
import 'package:toast/toast.dart';

var rideId,
    startPoint,
    endPoint,
    pickUp,
    seatsAvailable,
    cost,
    startDate,
    startTime,
    ststus,
    mobile;

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
                        Row(
                          children: <Widget>[
                            Text(
                              'End Point : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(endPoint),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'PickUp Point : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(pickUp),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Seats Available : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(seatsAvailable),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Cost : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(cost+' ₹'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Start Date : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(startDate),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Start Time : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(startTime),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.0,),
              Text('Select number of seats:'),
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
