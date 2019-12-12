import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_demo/FirstPage.dart';
import 'Driver_homepage_drawer.dart';
import 'package:toast/toast.dart';
import 'Search_trip.dart';

class Driver_home_page extends StatefulWidget {
  @override
  _Driver_home_pageState createState() => _Driver_home_pageState();
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

class _Driver_home_pageState extends State<Driver_home_page> {
  List<Gender> _gender = Gender.getselectedGender();
  List<DropdownMenuItem<Gender>> _dropDownMenuItams;
  Gender _selectedGender;

  var containerindex = 0;
  var pickUp = '', destination = '', gender = '';
  TextEditingController cpickUp = new TextEditingController(text: 'Rajkot');
  TextEditingController cdestination = new TextEditingController(text: 'Jamnagar');

//  static var First_container = Container(
//    color: Colors.indigo,
//  );
//  static var Second_container = Container(
//    color: Colors.orange,
//  );
  // List of container
//  List<Container> container = [First_container, Second_container];
//  //list of colors
//  List<Color> color = [Colors.indigo, Colors.orange];
//  var colorindex = 0;

  @override
  void initState() {
    // TODO: implement initState
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

  onChangeDropDownMenuItem(Gender sealectedGender) {
    setState(() {
      _selectedGender = sealectedGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Rider'),
      ),
      drawer: Driver_homepage_drawer(),

//appBar: AppBar(backgroundColor: color[colorindex]),
//      appBar: AppBar(
//        title: Text('Driver Home Page'),
//      ),
//        bottomNavigationBar: CurvedNavigationBar(
//            backgroundColor: color[colorindex],
//            onTap: (index) {
//              setState(() {
//                colorindex = index;
//                containerindex = index;
//              });
//            },
//            items: [
//              Icon(
//                Icons.map,
//                size: 30,
//              ),
//              Icon(
//                Icons.account_circle,
//                size: 30,
//              ),
//            ]),
      body: Container(
        color: Colors.blue.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(
                'Enter PickUp Point :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                controller: cpickUp,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Text('Enter Destination Point :',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                controller: cdestination,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Available for(Gender) : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: DropdownButton(
                      value: _selectedGender,
                      items: _dropDownMenuItams,
                      onChanged: onChangeDropDownMenuItem),
                ),
              ],
            ),

            // SizedBox(height: 10.0,),
            //  Text('Gender Selected : ${_selectedGender.name}'),
            SizedBox(
              height: 17.0,
            ),
            Center(
                child: MaterialButton(
              onPressed: search,
              child: Text(
                'Search',
                style: TextStyle(fontSize: 15),
              ),
              color: Colors.amberAccent,
              padding: EdgeInsets.fromLTRB(75, 15, 75, 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            )),
            MaterialButton(
                onPressed: () {
                  setState(() {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstPage()));
                    Navigator.pushReplacementNamed(context, '/FirstPage');
                  });
                },
                color: Colors.deepOrange,
                child: Icon(
                  Icons.arrow_back,
                  size: 50,
                ),
                shape: CircleBorder())
          ],
        ),
      ),
    );
  }

  void search() {
    setState(() {
      pickUp = cpickUp.text;
      destination = cdestination.text;
      gender = _selectedGender.name.toString();
      if (pickUp == '' || destination == '') {
        setState(() {
          Toast.show("Please fill all the details.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Search_trip(pickUp, destination, gender)));
      }
    });
  }
}
