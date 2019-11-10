import 'package:flutter/material.dart';
import 'place_item_res.dart';
import 'ride_picker_page.dart';
import 'package:map_demo/GoogleMap/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

class RidePicker extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;
  RidePicker(this.onSelected);
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  AppState appState = AppState();

  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  var frm;
  var adress = 'vbsiv';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    frm = 'Pick Up';
//     print('======================================================================'
//         '==================================================================================================================');
//     print(appState.locationController.toString());
  }

  Future<void> savedPrefrence(String fromTo, String whereTo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('fromTo', fromTo);
    pref.setString('whereTo', whereTo);
    pref.commit();
    return;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

//    print('from address   '+fromAddress.name.toString());
//    print('to address'+toAddress.name.toString());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Color(0x88999999), offset: Offset(0, 5), blurRadius: 5.0)
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RidePickerPage(
                            fromAddress == null ? "" : fromAddress.name,
                            (place, isFrom) {
                          widget.onSelected(place, isFrom);
                          fromAddress = place;
                          setState(() {
                            frm = fromAddress.name;
                            adress = fromAddress.address;
                            print(fromAddress.lat);
                            print(fromAddress.lng);
                            savedPrefrence(fromAddress.name, toAddress.name);
                            appState.sendRequest(
                                fromAddress.name, toAddress.name);
                          });
                        }, true)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                      width: 50.0,
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 2),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: Colors.black)),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 50.0),
                      child: Text(
                        frm,
                        // fromAddress == null ? "where to go ?" : fromAddress.name,
                        /*fromAddress == null ? "pickup location" : fromAddress.name*/
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: fromAddress == null
                                ? Colors.grey
                                : Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        RidePickerPage(toAddress == null ? '' : toAddress.name,
                            (place, isFrom) {
                          widget.onSelected(place, isFrom);
                          toAddress = place;
                          setState(() {
                            appState.sendRequest(
                                toAddress.name, fromAddress.name);
                            savedPrefrence(fromAddress.name, toAddress.name);
                          });
                        }, false)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                      width: 50.0,
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 2),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: Colors.blue)),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 50.0),
                      child: Text(
                        toAddress == null ? "Where To Go ?" : toAddress.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color:
                                toAddress == null ? Colors.grey : Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
