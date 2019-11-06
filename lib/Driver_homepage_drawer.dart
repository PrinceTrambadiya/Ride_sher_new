import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

String _uname = '',_name='',_email='';

//"name":"Prince Trambadiya","password":"123","email":"princetrambadiya123@gmail.com","mobile":"9512252645","dob":"12\/12\/1998","address":"Ahmedabad"

class Driver_homepage_drawer extends StatefulWidget {
  @override
  _Driver_homepage_drawerState createState() => _Driver_homepage_drawerState();
}

var data;

class _Driver_homepage_drawerState extends State<Driver_homepage_drawer> {
  @override
  var mobile = '';

  var name = "", email = "", dob = "", address = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print('hello');
    _getPrefrence();
  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    _name = pref.getString('name');
    _email = pref.getString('email');
    mobile = _uname.toString();
    setState(() {
      name = _name.toString();
      email = _email.toString();
    });


    print(mobile);
    if (mobile != "") {
      print('add');
     // print(mobile);
//      print(name);
//      print(email);
    //  addData(mobile);
    } else {
      print('nathi aayo number');
    }
  }

//  Future<void> addData(mobile) async {
//    final response = await http
//        .post("https://ridesher.000webhostapp.com/Fatch_data.php", body: {
//      "mobile": mobile,
//    });
//
//    data = json.decode(response.body);
////    var typePass = pass;
////    var fatchPass = data[0]['password'];
//
//    setState(() {
//      name = data[0]['name'];
//      email = data[0]['email'];
//      dob = data[0]['dob'];
//      address = data[0]['address'];
//    });
//
//
////    print(name);
////    print(email);
////    print(dob);
////    print(address);
//  }

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
                      backgroundImage: AssetImage('images/logo_.jpg'),
                      radius: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                    child: Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 1),
                    child: Text(
                      email,
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
