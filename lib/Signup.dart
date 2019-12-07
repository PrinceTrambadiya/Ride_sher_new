import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:toast/toast.dart';

var date1 = '';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class Gender {
  int id;
  String name;

  Gender(this.id, this.name);

  static List<Gender> getselectedGender() {
    return <Gender>[
      Gender(1, 'Male'),
      Gender(2, 'Female'),
      Gender(3, 'Other'),
    ];
  }
}

String emailValue = '';
String mobileValue = '';
Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
Pattern pattern2 = r'^[6789]\d{9}$';

class _SignupState extends State<Signup> {
  List<Gender> _gender = Gender.getselectedGender();
  List<DropdownMenuItem<Gender>> _dropDownMenuItams;
  Gender _selectedGender;

  FocusNode namefocus;
  FocusNode emailfocus;
  FocusNode mobilefocus;
  FocusNode dobfocus;
  FocusNode genderfocus;
  FocusNode passwordfocus;
  FocusNode confirmfocus;

  TextEditingController cname = new TextEditingController();
  TextEditingController cmobile = new TextEditingController();
  TextEditingController cpassword = new TextEditingController();
  TextEditingController cconfirmpassword = new TextEditingController();
  TextEditingController cemail = new TextEditingController();
  TextEditingController cdob = new TextEditingController();
  TextEditingController cgender = new TextEditingController();
  TextEditingController centerOPT = new TextEditingController();

  DateTime _date = new DateTime.now();

  var rng = new Random();
  var random;
  var msg = '', gender = '', bDate = '';

  DateTime _dateTime;
  RegExp regex = new RegExp(pattern);
  RegExp regex2 = new RegExp(pattern2);

  var error = Text('Error');
  var success = Text('You are Done.');

  bool _ishidden1 = true;
  bool _ishidden2 = true;
  var hintText1 = 'Password';
  var hintText2 = 'Confirm password';
  void _visibility1() {
    setState(() {
      _ishidden1 = !_ishidden1;
    });
  }

  void _visibility2() {
    setState(() {
      _ishidden2 = !_ishidden2;
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
      });
    }
  }

  void addData() {
    var url = "https://ridesher.000webhostapp.com/insert_registration.php";
    http.post(url, body: {
      "name": cname.text,
      "password": cpassword.text,
      "email": cemail.text,
      "mobile": cmobile.text,
      "dob": bDate.toString(),
      "gender": gender.toString()
    });
  }

  void validUser() {
    random = rng.nextInt(1000000);
    var url1 = "https://ridesher.000webhostapp.com/sendSMS.php";
    http.post(url1, body: {
      "mobile": cmobile.text,
      "text": 'Your Ride Share OTP Is ' + random.toString(),
    });
  }

  void alertBox() {
    //validUser();
//    random = rng.nextInt(1000000);
//    print(random);
    setState(() {
      AlertDialog dialog = new AlertDialog(
        backgroundColor: Colors.green.shade200,
        shape: RoundedRectangleBorder(
            side: BorderSide(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(30)),
        title: Text('Verifaction'),
        content: TextField(
          controller: centerOPT,
          decoration: InputDecoration(hintText: 'Enter OTP'),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
//                                  Navigator.pop(context);
//                                  Navigator.pop(context);
//                                  Navigator.pushReplacementNamed(context, '/Login');;
                setState(() {
//                  if (centerOPT.text == random.toString()) {
//                    addData();
//                    Navigator.pushReplacementNamed(context, '/Login');
//                  }
//                  else if (centerOPT.text == ''){
//                    setState(() {
//                      Toast.show("Please Enter OTP.", context,
//                          duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
//                    });
//                  }
//                  else{
//                    setState(() {
//                      Toast.show("OTP dose not match.", context,
//                duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
//                    });
//                  }
//                  addData();
                  Navigator.pushReplacementNamed(context, '/Login');
                });
              },
              color: Colors.blue.shade200,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Text('Done',
                  style: TextStyle(fontSize: 20, color: Colors.black))),
        ],
      );
      showDialog(context: context, child: dialog);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    namefocus = FocusNode();
    emailfocus = FocusNode();
    mobilefocus = FocusNode();
    dobfocus = FocusNode();
    genderfocus = FocusNode();
    passwordfocus = FocusNode();
    confirmfocus = FocusNode();
    _dropDownMenuItams = buildDropDownMenuItms(_gender);
    _selectedGender = _dropDownMenuItams[0].value;
  }

  List<DropdownMenuItem<Gender>> buildDropDownMenuItms(List gender) {
    List<DropdownMenuItem<Gender>> items = List();
    for (Gender seat in gender) {
      items.add(DropdownMenuItem(value: seat, child: Text(seat.name)));
    }
    return items;
  }

  onChangeDropDownMenuItem(Gender sealectedGender) {
    setState(() {
      _selectedGender = sealectedGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue.shade50,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New ',
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                    ),
                    Text(
                      'User',
                      style: TextStyle(color: Colors.cyan, fontSize: 25),
                    ),
                  ],
                ),
              ),
//            Padding(
//              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
//              child: Image.asset(
//                'images/backgroundgif.gif',
//                height: 200,
//              ),
//            ),

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(emailfocus);
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: cname,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  focusNode: emailfocus,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(mobilefocus);
                  },
                  controller: cemail,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Email Id',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  focusNode: mobilefocus,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(dobfocus);
                  },
                  controller: cmobile,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Mobile number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
//              Padding(
//                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
//                child: TextField(
//                  textInputAction: TextInputAction.next,
//                  focusNode: dobfocus,
//                  onSubmitted: (text) {
//                    FocusScope.of(context).requestFocus(genderfocus);
//                  },
//                  controller: cdob,
//                  keyboardType: TextInputType.datetime,
//                  style: TextStyle(color: Colors.white),
//                  decoration: InputDecoration(
//                      hintStyle: TextStyle(color: Colors.white),
//                      enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.blue),
//                          borderRadius: BorderRadius.circular(20.0)),
//                      hintText: 'Date Of Birth',
//                      border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(20.0))),
//                ),
//              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Select Date Of Birth : ',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _selectedDate(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        SizedBox(width: 7,),
                        Text(
                            '${_date.toLocal().toString().substring(0, 10)}',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ],
              )

//              Padding(
//                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
//                child: TextField(
//                  textInputAction: TextInputAction.next,
//                  focusNode: genderfocus,
//                  onSubmitted: (text) {
//                    FocusScope.of(context).requestFocus(passwordfocus);
//                  },
//                  textCapitalization: TextCapitalization.sentences,
//                  controller: cgender,
//                  maxLines: 4,
//                  style: TextStyle(color: Colors.white),
//                  decoration: InputDecoration(
//                      hintStyle: TextStyle(color: Colors.white),
//                      enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.blue),
//                          borderRadius: BorderRadius.circular(20.0)),
//                      hintText: 'Gender',
//                      border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(20.0))),
//                ),
//              ),
              ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Gender : ',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: MaterialButton(
                      //  color: Colors.white,
                      onPressed: () {},
                      child: DropdownButton(
                          iconEnabledColor: Colors.blueAccent,
                          value: _selectedGender,
                          items: _dropDownMenuItams,
                          onChanged: onChangeDropDownMenuItem),
                    ),
                  ),
                ],
              ),
//              Padding(
//                padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
//                child: Row(
//                  children: <Widget>[
//                    Radio(value: 0, groupValue: first, onChanged: (var value){
//                      setState(() {
//                        first = value;
//                      });
//
//                    },activeColor: Colors.blue,),
//                    Radio(value: 1, groupValue: null, onChanged: null)
//                  ],
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  focusNode: passwordfocus,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(confirmfocus);
                  },
                  controller: cpassword,
                  style: TextStyle(color: Colors.black),
                  obscureText: hintText1 == "Password" ? _ishidden1 : false,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Password',
                      suffixIcon: hintText1 == "Password"
                          ? IconButton(
                              icon: _ishidden1
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.blue,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.blue,
                                    ),
                              onPressed: _visibility1)
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  focusNode: confirmfocus,
                  onSubmitted: (text) {
                    signup();
                  },
                  controller: cconfirmpassword,
                  style: TextStyle(color: Colors.black),
                  obscureText:
                      hintText2 == "Confirm password" ? _ishidden2 : false,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: hintText2,
                      suffixIcon: hintText2 == "Confirm password"
                          ? IconButton(
                              icon: _ishidden2
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.blue,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.blue,
                                    ),
                              onPressed: _visibility2)
                          : null,
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
                    child: Text("GENERATE OTP", style: TextStyle(fontSize: 15)),
                    onPressed: () {
                      signup();
                    },
                    padding: EdgeInsets.fromLTRB(42, 5, 42, 5),
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

  void signup() {
    setState(() {
      var n = cname.text;
      var m = cmobile.text;
      var p = cpassword.text;
      bDate = _date.toLocal().toString().substring(0, 10);
      var e = cemail.text;
      var cp = cconfirmpassword.text;
      gender = _selectedGender.name.toString();
      if (n == "" ||
          m == "" ||
          p == "" ||
          bDate == "" ||
          e == "" ||
          p == '' ||
          cp == '') {
        setState(() {
          Toast.show("Please fill all the details.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      } else if (p != cp) {
        setState(() {
          Toast.show("Both password dose not match.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      } else if (!regex.hasMatch(e)) {
        setState(() {
          Toast.show("Enter valid Email id.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      } else if (!regex2.hasMatch(m)) {
        setState(() {
          Toast.show("Enter valid Mobile number.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      } else {
        alertBox();
      }
    });
  }
}
