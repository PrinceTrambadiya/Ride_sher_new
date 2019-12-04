import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'FirstPage.dart';

String _uname = '', _fromTo = '', _whereTo = '',_carName='',_carNumberPlate='';

class Add_Trip extends StatefulWidget {
  @override
  _Add_TripState createState() => _Add_TripState();
}

class Gender {
  int id;
  String name;

  Gender(this.id, this.name);

  static List<Gender> getselectedGender() {
    return <Gender>[
      Gender(1, 'Male'),
      Gender(2, 'Female'),
      Gender(3, 'Both'),
    ];
  }
}

class _Add_TripState extends State<Add_Trip> {

  List<Gender> _gender = Gender.getselectedGender();
  List<DropdownMenuItem<Gender>> _dropDownMenuItams;
  Gender _selectedGender;

  var fromTo = "", whereTo = "", dob = "", address = "",carName='',carNumberPlate='',ride_id='',ststus=0;

  var mobile = '', start_date = "", start_time = "", start_point = '', end_point = '', seats_available = '',cost='',pick_up='',gender='';

  int availableSeats1;


  TextEditingController cSeats = new TextEditingController();
  TextEditingController cStartPoint;
  TextEditingController cEndPoint;
  TextEditingController cPickUp = new TextEditingController();
  TextEditingController cCost = new TextEditingController();
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
    _getPrefrence();
    _dropDownMenuItams = buildDropDownMenuItms(_gender);
    _selectedGender = _dropDownMenuItams[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Gender>> buildDropDownMenuItms(List gender) {
    List<DropdownMenuItem<Gender>> items = List();
    for (Gender seat in gender) {
      items.add(DropdownMenuItem(value: seat, child: Text(seat.name)));
    }
    return items;
  }

  onChangeDropDownMenuItem(Gender sealectedGender)
  {
    setState(() {
      _selectedGender = sealectedGender;
    });
  }

  @override
  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2022));
    if (picked != null && picked != _date) {
      print('Date selected : ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      print('Date selected : ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    _fromTo = pref.getString('fromTo');
    _whereTo = pref.getString('whereTo');
//    _carName = pref.getString('CarName');
//    _carNumberPlate = pref.getString('CarNumberPlate');
    setState(() {
      mobile = _uname.toString();
      fromTo = _fromTo.toString();
      whereTo = _whereTo.toString();

      cEndPoint = new TextEditingController(text: whereTo);
      cStartPoint = new TextEditingController(text: fromTo);
//      print(whereTo);
//      print(fromTo);
    });
  }

  void addData() {
//    print('Bunty');
//    print(start_time.toString());
//    print(start_date.toString());
//    print(start_point.toString());
//    print(end_point.toString());
//    print(pick_up.toString());
//    print(seats_available.toString());
//    print(mobile.toString());
//    print(ststus.toString());
//    print(cost.toString());
//    print(ride_id.toString());

    var url = "https://ridesher.000webhostapp.com/insert_panding_trips.php";
    http.post(url, body: {
      "ride_id": ride_id.toString(),
      "mobile": mobile.toString(),
      "start_point": start_point.toString(),
      "end_point": end_point.toString(),
      "pick_up": pick_up.toString(),
      "seats_available": seats_available.toString(),
      "cost": cost.toString(),
      "start_date": start_date.toString(),
      "start_time": start_time.toString(),
      "ststus": ststus.toString(),
      "gender": gender.toString(),
    });
    removeData();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FirstPage()));
  }

  removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("fromTo");
    prefs.remove("whereTo");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrange,
        title: Text('Add Trip'),
      ),
      body: Container(color: Colors.blue.shade100,
        child: ListView(
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text('Starting Point : ',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: TextField(

                    textCapitalization: TextCapitalization.characters,
                    controller: cStartPoint,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text('Ending Point :',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    controller: cEndPoint,
                    enabled: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text('Pick Up Point :',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    controller: cPickUp,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text('Number Of Seats Available :',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    controller: cSeats,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text('Cost :',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    controller: cCost,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
//            Row(
//              children: <Widget>[
//                TextField(
//                  decoration: InputDecoration(hintText: "Enter Date"),
//                ),
//                IconButton(icon: Icon(Icons.date_range), onPressed: (){_selectTime(context);})
//              ],
//            ),


                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text('Available for(Gender) : ',style: TextStyle(fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: DropdownButton(
                      value: _selectedGender,
                      items: _dropDownMenuItams,
                      onChanged: onChangeDropDownMenuItem),
                ),

               // Text('Gender Selected : ${_selectedGender.name}'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text('Select Date Of Trip : ',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: RaisedButton(
                    onPressed: () {
                      _selectedDate(context);
                    },
                    child: Text('Date'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text('Date selected : ${_date.toLocal().toString().substring(0,10)}'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text('Select Time Of Trip : ',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: RaisedButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Text('Time'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text('Time selected : ${_time.format(context)}'),
                ),
                Center(
                  child: MaterialButton(
                    child: Text('CONFIRM'),
                    color: Colors.yellow,
                    onPressed: () {
                      setState(() {
                        addTrip();
                      });

                    },
                    padding: EdgeInsets.fromLTRB(75, 10, 75, 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addTrip() {
    setState(() {
       start_point = cStartPoint.text;
       end_point = cEndPoint.text;
       seats_available = cSeats.text;
       availableSeats1 = int.parse(seats_available);
       pick_up = cPickUp.text;
       cost = cCost.text;
      start_date =  _date.toLocal().toString().substring(0,10);
      start_time = _time.format(context);
      ride_id = mobile + '_' + start_date + '_' + start_time;
      gender = _selectedGender.name.toString();

//      TimeOfDay _time1 = new TimeOfDay.now();
//      var time1 = _time1.format(context);
//      DateTime _date1 = new DateTime.now();
//      var date1 = _date.toLocal().toString().substring(0,10);

        if(start_point == '' || end_point=='' || pick_up== '' || availableSeats1 == ''  || start_date == '' || start_time == '' || gender == '')
          {
            setState(() {
              Toast.show("Please fill all the details.", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
            });
          }
        else if(availableSeats1 > 7)
          {
            setState(() {
              Toast.show('Available seats should be 7 or less than 7.', context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
            });
          }
        else
          {
            setState(() {
              addData();
              Toast.show('Trip successfuly added.', context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
            });
          }
    });
  }
}