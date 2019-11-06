import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

String _uname = '', _name = '', _email = '',_carName='',_carNumberPlate='';

class Add_Trip extends StatefulWidget {
  @override
  _Add_TripState createState() => _Add_TripState();
}

class _Add_TripState extends State<Add_Trip> {
  var mobile = '';

  var name = "", email = "", dob = "", address = "",carName='',carNumberPlate='';

  TextEditingController cSeats = new TextEditingController();
  TextEditingController cStartPoint = new TextEditingController();
  TextEditingController cEndPoint = new TextEditingController();
  TextEditingController cPickUp = new TextEditingController();
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  var date = "", time = "", sp = '', ep = '', as = '';

  @override
  void initState() {
    // TODO: implement initState
    _getPrefrence();
    super.initState();
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
    _name = pref.getString('name');
    _email = pref.getString('email');
    _carName = pref.getString('CarName');
    _carNumberPlate = pref.getString('CarNumberPlate');
    setState(() {
      mobile = _uname.toString();
      name = _name.toString();
      email = _email.toString();
      carName = _carName.toString();
      carNumberPlate = _carNumberPlate.toString();
//      print(mobile);
//      print(name);
//      print(email);
//      print(carName);
//      print(carNumberPlate);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Trip'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Starting Point'),
                TextField(
                  controller: cStartPoint,
                ),
                Text('Ending Point'),
                TextField(
                  controller: cEndPoint,
                ),
                Text('Pick Up Point'),
                TextField(
                  controller: cPickUp,
                ),
                Text('Number Of Seats Available'),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: cSeats,
                ),
//            Row(
//              children: <Widget>[
//                TextField(
//                  decoration: InputDecoration(hintText: "Enter Date"),
//                ),
//                IconButton(icon: Icon(Icons.date_range), onPressed: (){_selectTime(context);})
//              ],
//            ),
                Text('\n\nSelect Date Of Trip'),
                RaisedButton(
                  onPressed: () {
                    _selectedDate(context);
                  },
                  child: Text('Date'),
                ),
                Text('Date selected : ${_date.toLocal()}'),
                Text('\n\nSelect Time Of Trip'),
                RaisedButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: Text('Time'),
                ),
                Text('Time selected : ${_time.format(context)}'),
                MaterialButton(
                  child: Text('CONFIRM'),
                  color: Colors.lightBlue,
                  onPressed: () {
                    setState(() {
                      addTrip();
                    });
                  },
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
      var sp = cStartPoint.text;
      var ep = cEndPoint.text;
      var as = cSeats.text;
      int as1 = int.parse(as);
      var pp = cPickUp.text;
      date = _date.toLocal().toString();
      time = _time.format(context);

        if(sp == '' || ep=='' || pp== '' || as1 == ''  || date == '' || time == '')
          {
            setState(() {
              Toast.show("Please fill all the details.", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            });
          }
        else if(as1 > 7)
          {
            setState(() {
              Toast.show('Available seats should be 7 or less than 7.', context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            });
          }
        else
          {
            setState(() {
              Toast.show('Trip successfuly added..', context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            });
          }

//      print(sp);
//      print(ep);
//      print(pp);
//      print(as);
//      print(date);
//      print(time);
//      print(mobile);
//      print(email);
//      print(name);
    });
  }
}
