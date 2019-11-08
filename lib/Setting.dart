import 'package:flutter/material.dart';
import 'Update_personal_details.dart';
import 'ConfirmPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Update_driver_details.dart';

String _name='', _email='', _dob='', _adderss='',_uname='',_carNumberPlate='',_driving_licence='',_rcbook='',_carName='';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  var name='',email='',dob='', address='',mobile='',carName='',carNumberPlate='',DriverLicence='',rcBook='';


  @override
  void initState() {
    // TODO: implement initState
    _getPrefrence();
    super.initState();
  }

  _getPrefrence() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _uname = pref.getString('saved_uname');
      _name = pref.getString('name');
      _email = pref.getString('email');
      _dob = pref.getString('dob');
      _adderss = pref.getString('address');
      _carName = pref.getString('CarName');
      _carNumberPlate = pref.getString('CarNumberPlate');
      _driving_licence = pref.getString('DriverLicence');
      _rcbook = pref.getString('RcNumber');
      mobile = _uname.toString();
      name = _name.toString();
      email = _email.toString();
      dob = _dob.toString();
      address = _adderss.toString();
      carName = _carName.toString();
      carNumberPlate = _carNumberPlate.toString();
      DriverLicence = _driving_licence.toString();
      rcBook = _rcbook.toString();
      name1 = name;
      email1 = email;
      dob1 = dob;
      address1 = address;
//      print(mobile);
//      print(name);
//      print(email);
//      print(dob);
//      print(address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            MaterialButton(onPressed: (){
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Update_personal_details(name,email,dob,address,mobile)));
              });
            },child: Text('Update Personal Details'),color: Colors.amberAccent,),
            MaterialButton(onPressed: (){
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Update_driver_details(carName,carNumberPlate,rcBook,DriverLicence,mobile)));
              });
            },child: Text('Update Driver Details'),color: Colors.amberAccent,),
            MaterialButton(onPressed: (){
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmPassword(mobile)));
              });
            },child: Text('Change Password'),color: Colors.amberAccent,),
           ],
        ),
      ),
    );
  }
}
