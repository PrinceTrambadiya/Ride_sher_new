import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Driver_homepage_drawer.dart';

class Driver_home_page extends StatefulWidget {
  @override
  _Driver_home_pageState createState() => _Driver_home_pageState();
}

class _Driver_home_pageState extends State<Driver_home_page> {
  var containerindex = 0;
  // List of container
  List<Container> container = [Container(color: Colors.indigo,),Container(color: Colors.orange,),];
  //list of colors
  List<Color> color = [Colors.indigo,Colors.orange];
  var colorindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Driver_homepage_drawer(),
      appBar: AppBar(
        title: Text('Driver Home Page'),
      ),
      bottomNavigationBar: CurvedNavigationBar(backgroundColor: color[colorindex],onTap: (index){
        setState(() {
          colorindex = index;
          containerindex = index;
        });
      },
          items: [
            Icon(Icons.map,size: 30,),
            Icon(Icons.account_circle,size: 30,),

          ]

      ),
        body: container[containerindex]
    );
  }
}
