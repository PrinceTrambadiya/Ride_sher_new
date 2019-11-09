import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;


var name1='',email1='',dob1='', address1='',mobile1='';
Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';


class Update_personal_details extends StatefulWidget {

  var name2, email2, dob2, address2, mobile2;

  Update_personal_details( name2, email2,  dob2,  address2, mobile2)
  {
    this.name2 = name2;
    this.email2 = email2;
    this.dob2 = dob2;
    this.address2 = address2;
    this.mobile2 = mobile2;
    name1 = name2;
    email1 = email2;
    dob2 = dob1;
    address1 = address2;
    mobile1 = mobile2;
  }
  @override
  _Update_personal_detailsState createState() => _Update_personal_detailsState();
}

class _Update_personal_detailsState extends State<Update_personal_details> {
  @override

  var name='',email='',dob='', address='',mobile=mobile1,dob2=dob1;
  DateTime _date = new DateTime.now();
  RegExp regex = new RegExp(pattern);

  TextEditingController cname = new TextEditingController(text: name1);
  TextEditingController cemail = new TextEditingController(text: email1);
  TextEditingController cdob = new TextEditingController(text: dob1);
  TextEditingController caddress = new TextEditingController(text: address1);


  @override
  void initState() {
    // TODO: implement initState
   // print(mobile);
    super.initState();
  }

  void editData() {
    print(name.toString());
    print(email.toString());
    print(dob.toString());
    print(address.toString());
    print(mobile.toString());
    setState(() {
      var url = "https://ridesher.000webhostapp.com/Update_personal_details.php";
      http.post(url,
          body: {"name": name.toString(), "email": email.toString(), "dob": dob.toString(),
            "address": address.toString(),"mobile": mobile.toString()});
    });
    savedPrefrence(name, email, dob, address);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/FirstPage');
  }

  Future<void> savedPrefrence(
      String name, String email, String dob, String address) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString('name', name);
      pref.setString('email', email);
      pref.setString('dob', dob);
      pref.setString('address', address);
      pref.commit();
      return;
    });
  }

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1960),
        lastDate: new DateTime(2022));
    if (picked != null && picked != _date) {
      print('Date selected : ${_date.toString()}');
      setState(() {
        _date = picked;
        dob2 =  _date.toString().substring(0,10);
      });
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Personal Details'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Name'),
                TextField(
                  controller: cname,
                ),
                Text('Email'),
                TextField(
                  controller: cemail,
                ),
                Text('Date Of Birth'),
//                TextField(
//                //  keyboardType: TextInputType.datetime,
//                  controller: cdob,
//
//                  onTap: (){setState(() {
//                    _selectedDate(context);
//                    //name1= _date.toLocal().toString().substring(0,10);
//                  });},
//                ),
                RaisedButton(
                  onPressed: () {
                    _selectedDate(context);
                  },
                  child: Icon(Icons.date_range),
                ),
                Text('Date selected :'+dob2),
                Text('Address'),
                TextField(
                  controller: caddress,
                ),
                MaterialButton(
                  child: Text('CONFIRM'),
                  color: Colors.amberAccent,
                  onPressed: () {
                    setState(() {
                      updateDetails();
                    });
                  },
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
      name = cname.text;
      email = cemail.text;
      dob =  dob2;
      address = caddress.text;

      if(name == '' || email == '' || dob == '' || address == ''  )
        {
          setState(() {
            Toast.show("Please fill all the details.", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
          });
        }
      else if(!regex.hasMatch(email))
      {
        setState(() {
          Toast.show("Wrong Email.", context,
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

