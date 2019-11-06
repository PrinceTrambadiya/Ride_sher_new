import 'package:flutter/material.dart';
//import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _uname = '';


class driver_details extends StatefulWidget {
  @override
  _driver_detailsState createState() => _driver_detailsState();
}

class _driver_detailsState extends State<driver_details> {
  FocusNode car_name;
  FocusNode rc_book_number;
  FocusNode car_numberPlate;
  FocusNode driver_licence;

  var error = Text('Error');
  var mobile='';
  var cn,crc,cnp,dl;

  TextEditingController ccar_name = new TextEditingController();
  TextEditingController crc_book_number = new TextEditingController();
  TextEditingController ccarr_numberPlate = new TextEditingController();
  TextEditingController cdriver_licence = new TextEditingController();

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
     mobile = _uname.toString();
   // print(mobile);
  }


  void initState() {
    // TODO: implement initState
    _getPrefrence();
  }

  void addData() {
    var url = "https://ridesher.000webhostapp.com/insert_driver_details.php";
    http.post(url, body: {
      "car_name": ccar_name.text,
      "rc_book_number": crc_book_number.text,
      "car_numberplate": ccarr_numberPlate.text,
      "driver_licence_number": cdriver_licence.text,
      "mobile": mobile,
    });
  }

//  Future<void> savedPrefrence(String carName, String rcBook, String carNumberPlate , String driverLicence) async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    pref.setString('carName', carName);
//    pref.setString('rcBook', rcBook);
//    pref.setString('carNumberPlate', carNumberPlate);
//    pref.setString('driverLicence', driverLicence);
//    pref.commit();
//    return;
//  }

  void alertBox() {
    setState(() {
      AlertDialog dialog = new AlertDialog(
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(
            side: BorderSide(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(30)),
        title: Text('Verifaction'),
        content: Text('Are You Sure?'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/driver_details');
                });
              },
              child: Text('No',
                  style: TextStyle(fontSize: 25, color: Colors.red))),
          FlatButton(
              onPressed: () {
                setState(() {
                  addData();
               //   savedPrefrence(cn,crc,cnp,dl);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/FirstPage');
                });
              },
              child: Text('Yes',
                  style: TextStyle(fontSize: 25, color: Colors.red))),
        ],
      );
      showDialog(context: context, child: dialog);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/ride1.jpg'),
                  fit: BoxFit.fill,
                  colorFilter:
                      ColorFilter.mode(Colors.black87, BlendMode.hardLight))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Driver ',
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                    ),
                    Text(
                      'Details',
                      style: TextStyle(color: Colors.cyan, fontSize: 25),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(rc_book_number);
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: ccar_name,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Car Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  focusNode: rc_book_number,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(car_numberPlate);
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: crc_book_number,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'RC Book Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  focusNode: car_numberPlate,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(driver_licence);
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: ccarr_numberPlate,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Car Number Plate',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  focusNode: driver_licence,
                  onSubmitted: (text) {
                    enterDetails();
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: cdriver_licence,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Driving Licence Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 5, 100, 0),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.cyan])),
                  child: Center(
                      child: MaterialButton(
                    splashColor: Colors.black,
                    child: Text("SUBMIT", style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      enterDetails();
                    },
                    padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void enterDetails() {
    setState(() {
       cn = ccar_name.text;
       crc = crc_book_number.text;
       cnp = ccarr_numberPlate.text;
       dl = cdriver_licence.text;
      if (cn != "" && crc != "" && cnp != "" && dl != "") {
        //validUser();
        alertBox();
//        addData();
      } else {
        error;
      }
    });
  }
}
