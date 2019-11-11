import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'place_item_res.dart';

String _uname = '';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

var data;

class _FirstPageState extends State<FirstPage> {
  var ls = new List();
  var mobile = '';

  logout log = new logout();
  var name = "", email = "", dob = "", address = "";

  var CarName = '',
      RcNumber = '',
      CarNumberPlate = '',
      DriverLicence = '';

  @override
  void initState() {
    // TODO: implement initState
    _getPrefrence();
    super.initState();
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
//    _addMarker(mkId, place);
//    addPolyline();
  }


//  removeData() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.remove("saved_uname");
//    prefs.remove("saved_pass");
//    prefs.remove("name");
//    prefs.remove("email");
//    prefs.remove("dob");
//    prefs.remove("address");
//    prefs.remove("CarName");
//    prefs.remove("RcNumber");
//    prefs.remove("CarNumberPlate");
//    prefs.remove("DriverLicence");
//  }
//
//    void logout() {
//    removeData();
//    Navigator.pushReplacementNamed(context, '/Login');
//  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    mobile = _uname.toString();
    print(mobile);
    if (mobile != "") {
      print('add');
      // print(mobile);
      addData(mobile);
      addData1(mobile);
    } else {
      print('nathi aayo number');
    }
  }

  Future<void> addData(mobile) async {
    final response = await http
        .post("https://ridesher.000webhostapp.com/Fatch_data.php", body: {
      "mobile": mobile,
    });

    data = json.decode(response.body);
//    var typePass = pass;
//    var fatchPass = data[0]['password'];

    setState(() {
      name = data[0]['name'];
      email = data[0]['email'];
      dob = data[0]['dob'];
      address = data[0]['address'];
      savedPrefrence(name, email, dob, address);
    });

//    print(name);
//    print(email);
//    print(dob);
//    print(address);
  }


  Future<void> savedPrefrence(
      String name, String email, String dob, String address) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('name', name);
    pref.setString('email', email);
    pref.setString('dob', dob);
    pref.setString('address', address);
    pref.commit();
    return;
  }

  Future<void> addData1(mobile) async {
    //  print(mobile);
    final response = await http
        .post("https://ridesher.000webhostapp.com/Fatch_Driverdata.php", body: {
      "mobile": mobile,
    });

    data = json.decode(response.body);
//    var typePass = pass;
    setState(() {
      CarName = data[0]['car_name'];
      RcNumber = data[0]['rc_book_number'];
         CarNumberPlate = data[0]['car_numberplate'];
      DriverLicence = data[0]['driver_licence_number'];
      savedPrefrence1(CarName,RcNumber,CarNumberPlate,DriverLicence);
    });
//    print(CarName);
//    print(RcNumber);
//    print(CarNumberPlate);
//    print(CarNumberPlate);
  }

  Future<void> savedPrefrence1(
      String CarName, String RcNumber, String CarNumberPlate, String DriverLicence) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('CarName', CarName);
    pref.setString('RcNumber', RcNumber);
    pref.setString('CarNumberPlate', CarNumberPlate);
    pref.setString('DriverLicence', DriverLicence);
    pref.commit();
    return;
  }

  @override
  Widget build(BuildContext context) {
//          ],
//        ));
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
//      appBar: AppBar(
//        title: Text('Home Page'),
//      ),
      body: Center(
        child: Container(
          height: 350,
          width: 500,

//          decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage('images/firstpagebackground.gif'),
//              fit: BoxFit.fill,
//            ),
//          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Container(
//                //child: RidePicker(onPlaceSelected),
//              ),

              Container(
                height: 50,
                width: 250,
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(25),
//                    gradient:
//                        LinearGradient(colors: [Colors.blue, Colors.cyan])),
                child: Center(
                    child: MaterialButton(
                      color: Colors.blue,
                  splashColor: Colors.black45,
                  child: Text("RIDER", style: TextStyle(fontSize: 18,color: Colors.white)),
                  onPressed: () {
                    setState(() {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => RidePicker(onPlaceSelected)));
                     Navigator.pushReplacementNamed(context, '/Driver_home_page');
                    });
                  },
                  padding: EdgeInsets.fromLTRB(76, 5, 76, 5),
                  height: 45,
                      minWidth:250 ,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadiusDirectional.horizontal(
                              end: Radius.elliptical(10, 10),
                              start: Radius.elliptical(10, 10))),
                )),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  height: 50,
                  width: 250,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(25),
//                      gradient:
//                          LinearGradient(colors: [Colors.blue, Colors.cyan])),
                  child: Center(
                      child: MaterialButton(
                        color: Colors.white,
                    splashColor: Colors.black45,
                    child: Text("DRIVER", style: TextStyle(fontSize: 18,color: Colors.blue )),
                    onPressed: () {
                      setState(() {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => Map()));
                        Navigator.pushReplacementNamed(context, '/Map');
                      });
                    },
                    padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                    height: 45,
                        minWidth: 250,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadiusDirectional.horizontal(
                                end: Radius.elliptical(10, 10),
                                start: Radius.elliptical(10, 10))),
                  )),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  height: 45,
                  width: 250,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(25),
//                      gradient:
//                          LinearGradient(colors: [Colors.blue, Colors.cyan])),
                  child: Center(
                      child: MaterialButton(
                        color: Colors.blue,
                    splashColor: Colors.black45,
                    child: Text("LOGOUT", style: TextStyle(fontSize: 18,color: Colors.white)),
                    onPressed: () {
//                      logout();
                    log.removeData();
                      //Navigator.pushReplacementNamed(context, '/Login');
                      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
                    },
                    padding: EdgeInsets.fromLTRB(90, 5, 90, 5),
                    height: 45,
                        minWidth: 230,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadiusDirectional.horizontal(
                                end: Radius.elliptical(10, 10),
                                start: Radius.elliptical(10, 10))),
                  )),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class logout{

  removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("saved_uname");
    prefs.remove("saved_pass");
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("dob");
    prefs.remove("address");
    prefs.remove("CarName");
    prefs.remove("RcNumber");
    prefs.remove("CarNumberPlate");
    prefs.remove("DriverLicence");
  }
}