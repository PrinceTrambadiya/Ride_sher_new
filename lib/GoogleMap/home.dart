import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_demo/GoogleMap/app_state.dart';
import 'package:provider/provider.dart';

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

class _MapState extends State<Map> {
  LatLng pickupmarkers;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return SafeArea(
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
                    appState.markers.add(Marker(
                        markerId: MarkerId(pickupmarkers.toString()),
                        position: pickupmarkers,
                        infoWindow: InfoWindow(
                            title: 'pick up point', snippet: "go here"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
                    appState.pickupmarkers.add(
                        Marker(markerId: MarkerId(pickupmarkers.toString())));
                    print(appState.pickupmarkers);
                    appState.notifyListeners();
                  },
                ),

                Positioned(
                  bottom: 100.0,
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
                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 45.0,
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
                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
