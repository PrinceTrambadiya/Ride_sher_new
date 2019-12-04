import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var carName1='',carNumberPlate1='',rcBook1='', driverLicence1='',mobile1='';
Pattern numberPlatePattern = r'^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$';
Pattern driverLicencePattern = r'^(?<intro>[A-Z]{2})(?<numeric>\d{2})(?<year>\d{4})(?<tail>\d{7})$';
Pattern rcBookPattern = r'^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$';

class Update_driver_details extends StatefulWidget {
  var carName2, carNumberPlate2, rcBook2, driverLicence2,mobile2;

  Update_driver_details( carName2, carNumberPlate2,  rcBook2,  driverLicence2, mobile2)
  {
    this.carName2 = carName2;
    this.carNumberPlate2 = carNumberPlate2;
    this.rcBook2 = rcBook2;
    this.driverLicence2 = driverLicence2;
    this.mobile2 = mobile2;
    carName1 = carName2;
    carNumberPlate1 = carNumberPlate2;
    rcBook1 = rcBook2;
    driverLicence1 = driverLicence2;
    mobile1 = mobile2;
  }

  @override
  _Update_driver_detailsState createState() => _Update_driver_detailsState();
}

class _Update_driver_detailsState extends State<Update_driver_details> {
  @override

  RegExp regex = new RegExp(numberPlatePattern);
  RegExp regex2 = new RegExp(driverLicencePattern);
  RegExp regex3 = new RegExp(rcBookPattern);
  var carName='',carNumberPlate='',rcBook='', driverLicence='',mobile=mobile1;


  TextEditingController ccarName = new TextEditingController(text: carName1);
  TextEditingController ccarNumberPlate = new TextEditingController(text: carNumberPlate1);
  TextEditingController crcBook = new TextEditingController(text: rcBook1);
  TextEditingController cdriverLicence = new TextEditingController(text: driverLicence1);
  TextEditingController cmobile = new TextEditingController(text: mobile1);

  @override
  void initState() {
    // TODO: implement initState
    print(carName1);
    super.initState();
  }

  void editData() {
    print(carName.toString());
    print(carNumberPlate.toString());
    print(rcBook.toString());
    print(driverLicence.toString());
    print(mobile.toString());
    setState(() {
      var url = "https://ridesher.000webhostapp.com/Update_driver_details.php";
      http.post(url,
          body: {"car_name": carName.toString(), "rc_book_number": rcBook.toString(), "car_numberplate": carNumberPlate.toString(),
            "driver_licence_number": driverLicence.toString(),"mobile": mobile.toString()});
    });
    savedPrefrence1(carName,rcBook,carNumberPlate,driverLicence);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    //Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/FirstPage');
  }

  Future<void> savedPrefrence1(
      String CarName, String RcNumber, String CarNumberPlate, String DriverLicence) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString('CarName', CarName);
      pref.setString('RcNumber', RcNumber);
      pref.setString('CarNumberPlate', CarNumberPlate);
      pref.setString('DriverLicence', DriverLicence);
      pref.commit();
      return;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrange,
        title: Text('Update Driver Details'),
      ),
      body: Container(color: Colors.blue.shade100,
        child: ListView(
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text('Car Name :',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    controller: ccarName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text('Number Plate :',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    controller: ccarNumberPlate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text('Rc Book :',style: TextStyle(fontWeight: FontWeight.bold) ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    controller: crcBook,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text('Driving Licence :',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    controller: cdriverLicence,
                  ),
                ),
                SizedBox(height: 20.08,),
                Center(
                  child: MaterialButton(
                    child: Text('CONFIRM'),
                    color: Colors.amberAccent,
                    onPressed: () {
                      setState(() {
                        updateDetails();
                      });
                    },padding: EdgeInsets.fromLTRB(75, 15, 75, 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30) ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void updateDetails()
  {
    setState(() {
      carName = ccarName.text;
      carNumberPlate = ccarNumberPlate.text;
      rcBook = crcBook.text;
      driverLicence = cdriverLicence.text;

      if(carName == '' || carNumberPlate == '' || rcBook == '' || driverLicence == ''  )
      {
        setState(() {
          Toast.show("Please fill all the details.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      }
      else if(!regex.hasMatch(carNumberPlate))
      {
        setState(() {
          Toast.show("Wrong NumberPlate.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      }
      else if(!regex2.hasMatch(driverLicence))
      {
        setState(() {
          Toast.show("Wrong Driving Licence.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      }
      else if(!regex3.hasMatch(rcBook))
      {
        setState(() {
          Toast.show("Wrong RcBook Number.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      }
      else
      {
        setState(() {
          editData();
          Toast.show('Upadte successfuly.', context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      }
//      print(name);
//      print(email);
//      print(dob);
//      print(address);

    });
  }
}
