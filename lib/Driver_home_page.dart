import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Driver_homepage_drawer.dart';

class Driver_home_page extends StatefulWidget {
  @override
  _Driver_home_pageState createState() => _Driver_home_pageState();
}

class _Driver_home_pageState extends State<Driver_home_page> {
  var containerindex = 0;

  static var First_container = Container(
    color: Colors.indigo,
  );
  static var Second_container = Container(
    color: Colors.orange,
  );
  // List of container
  List<Container> container = [First_container, Second_container];
  //list of colors
  List<Color> color = [Colors.indigo, Colors.orange];
  var colorindex = 0;
  @override
  Widget build(BuildContext context) {
    TextEditingController cpickUp = new TextEditingController();
    TextEditingController cdestation = new TextEditingController();
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
              TextField(
                controller: cpickUp,
              ),
              TextField(
                controller: cdestation,
              ),
            ],
          ),
        ),
    );
  }
}
