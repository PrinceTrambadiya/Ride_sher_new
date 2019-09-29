import 'package:flutter/material.dart';

class Driver_homepage_drawer extends StatefulWidget {
  @override
  _Driver_homepage_drawerState createState() => _Driver_homepage_drawerState();
}

class _Driver_homepage_drawerState extends State<Driver_homepage_drawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onLongPress: () {},
                    child: CircleAvatar(
                      backgroundImage: AssetImage(''),
                      radius: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                    child: Text(
                      'Sunny Patel',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 1),
                    child: Text(
                      'sunnyofficial792@gmail.com',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),

          //Drawer Page Content..........
                                    //...
                  //                   .

          ListTile(
            leading: Icon(Icons.strikethrough_s),
            title: Text('Sunny'),
            trailing: Icon(Icons.strikethrough_s),
          )
        ],
      ),
    );
  }
}
