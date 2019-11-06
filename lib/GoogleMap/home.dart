import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_demo/GoogleMap/app_state.dart';
import 'package:provider/provider.dart';
import 'package:map_demo/Add_Trip.dart';
import 'package:map_demo/Driver_details.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:map_demo/Driver_homepage_drawer.dart';

String _uname = '', _carName = '', _rcBook = '', _;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Map());
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

var data;

class _MapState extends State<Map> {
  LatLng pickupmarkers;
  var mobile = '',
      CarName = '',
      CarModelNumber = '',
      CarNumberPlate = '',
      DriverLicence = '';
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefrence();
  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    mobile = _uname.toString();
    addData(mobile);
    // print(mobile);
  }

  Future<void> addData(mobile) async {
    //  print(mobile);
    final response = await http
        .post("https://ridesher.000webhostapp.com/Fatch_Driverdata.php", body: {
      "mobile": mobile,
    });

    data = json.decode(response.body);
//    var typePass = pass;
    setState(() {
      CarName = data[0]['car_name'];
//         CarModelNumber = data[0]['car_model_number'];
//         CarNumberPlate = data[0]['car_numberplate'];
//         CarNumberPlate = data[0]['driver_licence_number'];
    });

    print(CarName);
  }

  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      drawer: Driver_homepage_drawer(),
      body: Container(
        child: SafeArea(
          child: appState.initialPosition == null
              ? Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Stack(
                  children: <Widget>[
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: appState.initialPosition, zoom: 20.0),
                      onMapCreated: appState.onCreated,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      compassEnabled: true,
                      markers: appState.markers,
                      onCameraMove: appState.onCameraMove,
                      polylines: appState.polyLines,
                      onTap: (LatLng point) {
                        pickupmarkers = point;
//                    appState.markers.add(Marker(
//                        markerId: MarkerId(pickupmarkers.toString()),
//                        position: pickupmarkers,
//                        infoWindow: InfoWindow(
//                            title: 'pick up point', snippet: "go here"),
//                        icon: BitmapDescriptor.defaultMarkerWithHue(
//                            BitmapDescriptor.hueBlue)));
                        appState.pickupmarkers.add(Marker(
                            markerId: MarkerId(pickupmarkers.toString())));
                        print(appState.pickupmarkers);
                        appState.notifyListeners();
                      },
                    ),
                    Positioned(
                      bottom: 700.0,
                      right: 15.0,
                      left: 15.0,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 5.0),
                                blurRadius: 10,
                                spreadRadius: 3)
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: appState.locationController,
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              width: 10,
                              height: 10,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "pick up",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 640.0,
                      right: 15.0,
                      left: 15.0,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 5.0),
                                blurRadius: 10,
                                spreadRadius: 3)
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: appState.destinationController,
                          textInputAction: TextInputAction.go,
                          onSubmitted: (value) {
                            appState.sendRequest(value);
                          },
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              width: 10,
                              height: 10,
                              child: Icon(
                                Icons.local_taxi,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "destination?",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 45,
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: bottomSheet,
                        tooltip: 'Cklick',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            //   color: Colors.red,
            height: 130,
            child: Container(
              decoration: BoxDecoration(
                  //     color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30))),
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.directions_car),
                      title: Text('Add Trip'),
                      onTap: addTrip),
                  ListTile(
                      leading: Icon(Icons.details),
                      title: Text('Car Details'),
                      onTap: addDetails),
                ],
              ),
            ),
          );
        });
  }

  void addTrip() {
    setState(() {
      if (CarName != "") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Add_Trip()));
      } else {
        setState(() {
          Toast.show("Please Fill Driver Details", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        });
      }
    });
  }

  void addDetails() {
    setState(() {
      if (CarName == "") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => driver_details()));
      } else {
        setState(() {
          Toast.show("Already Filled", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        });
      }
    });
  }
}

//                Positioned(
//                  child: MaterialButton(
//                    onPressed: () {
//                      setState(() {
//                        if (CarName != "") {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => Add_Trip()));
//                        } else {
//                          setState(() {
//                            Toast.show("Please Fill Driver Details", context,
//                                duration: Toast.LENGTH_SHORT,
//                                gravity: Toast.BOTTOM);
//                          });
//                        }
//                      });
//                    },
//                    child: Text("Add Trip"),
//                    color: Colors.red,
//                  ),
//                ),
//                Positioned(
//                  bottom: 700,
//                  child: MaterialButton(
//                    onPressed: () {
//                      setState(() {
//                        if (CarName == "") {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => driver_details()));
//                        } else {
//                          setState(() {
//                            Toast.show("Already Filled", context,
//                                duration: Toast.LENGTH_SHORT,
//                                gravity: Toast.BOTTOM);
//                          });
//                        }
//                      });
//                    },
//                    child: Text("Add Details"),
//                    color: Colors.red,
//                  ),
//                ),
