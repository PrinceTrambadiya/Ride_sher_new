import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Driver_homepage_drawer.dart';
import 'package:toast/toast.dart';
import 'Search_trip.dart';

class Driver_home_page extends StatefulWidget {
  @override
  _Driver_home_pageState createState() => _Driver_home_pageState();
}

class _Driver_home_pageState extends State<Driver_home_page> {
  var containerindex = 0;
  var pickUp='', destination='';
  TextEditingController cpickUp = new TextEditingController(text: 'delhi');
  TextEditingController cdestination = new TextEditingController(text: 'pune');

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
//  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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
          child: Column(
            children: <Widget>[
              Text('Enter PickUp Point'),
              TextField(
                textCapitalization: TextCapitalization.words,
                controller: cpickUp,
              ),
              Text('Enter Destination Point'),
              TextField(
                textCapitalization: TextCapitalization.words,
                controller: cdestination,
              ),
              MaterialButton(onPressed: search,child: Text('Search'),color: Colors.amberAccent,)
            ],
          ),
        ),
    );
  }
  void search()
  {
    setState(() {
      pickUp = cpickUp.text;
      destination = cdestination.text;
      if(pickUp == '' || destination == '')
        {
          setState(() {
            Toast.show("Please fill all the details.", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
          });
        }
      else
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Search_trip(pickUp,destination)));
        }
    });
  }
}
