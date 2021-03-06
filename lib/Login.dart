import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Signup.dart';
import 'Forgetpassword.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart' as t;
import 'package:toast/toast.dart';
//import 'Shared_data.dart';

//SharedData shr;
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

var data;
Pattern pattern2 = r'^[6789]\d{9}$';

class _LoginState extends State<Login> {
  FocusNode passwordfocus;

  TextEditingController cmobile = new TextEditingController();
  TextEditingController cpassword = new TextEditingController();
  TextEditingController centerOPT = new TextEditingController();
  var rng = new Random();
  var random;
  var msg = '';
  var hintText1 = 'Password';

  RegExp regex2 = new RegExp(pattern2);

  bool _ishidden = true;

  void _visibility() {
    setState(() {
      _ishidden = !_ishidden;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_connection();
    passwordfocus = FocusNode();
  }

  Future<void> check_connection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      t.Fluttertoast.showToast(
          msg: 'Internet Connection',
          toastLength: t.Toast.LENGTH_SHORT,
          timeInSecForIos: 1,
          backgroundColor: Colors.black26,
          textColor: Colors.white,
          fontSize: 14.0);
      return true;
    } else {
      t.Fluttertoast.showToast(
          msg: 'No Internet Connection',
          toastLength: t.Toast.LENGTH_SHORT,
          timeInSecForIos: 1,
          backgroundColor: Colors.black26,
          textColor: Colors.white,
          fontSize: 14.0);
      return false;
    }
  }

  Future<void> savedPrefrence(String uname, String pass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('saved_uname', uname);
    pref.setString('saved_pass', pass);
    pref.commit();
    return;
  }

  Future<void> addData(mobile, pass) async {
//    if (mobile == '9512252645' && pass == '123') {
//      //  print(pass+"in add data"+mobile);
//      savedPrefrence(mobile, pass);
//      Navigator.pushReplacementNamed(context, '/FirstPage');
//      return true;
//    } else {
//      setState(() {
//        msg = 'Login Fail';
//      });
//      return false;
//    }

    final response = await http.post(
        "https://ridesher.000webhostapp.com/login_registration.php",
        body: {
          "mobile": mobile,
        });

    data = json.decode(response.body);
    var typePass = pass;
    var fatchPass = data[0]['password'];

//    print(data);
    print(fatchPass);
    print(typePass);

    if (fatchPass == '') {
      setState(() {
        msg = 'Login Fail';
      });
    }

    if (fatchPass == typePass) {
      print("ganesh");
      setState(() {
        alertBox();
//          savedPrefrence(mobile, typePass);
//          Navigator.pushReplacementNamed(context, '/FirstPage');
      });
      //return true;
    } else if (fatchPass != typePass) {
      setState(() {
        msg = 'Login Fail';
      });
      //  return false;
    } else {
      setState(() {
        msg = 'Login Fail';
      });
    }
  }

  void validUser() {
    random = rng.nextInt(1000000);
    var url1 = "https://ridesher.000webhostapp.com/sendSMS.php";
    http.post(url1, body: {
      "mobile": cmobile.text,
      "text": 'Your R'
          ''
          'ide Share OTP Is ' + random.toString(),
    });
  }

  void alertBox() {
    setState(() {
        // validUser();
//      random = rng.nextInt(1000000);
//      print(random);
      AlertDialog dialog = new AlertDialog(
        backgroundColor: Colors.green.shade200,
        shape: RoundedRectangleBorder(
            side: BorderSide(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(30)),
        title: Row(
          children: <Widget>[
            Text('Verifaction'),
          ],
        ),
        content: TextField(
          controller: centerOPT,
          decoration: InputDecoration(hintText: 'Enter OTP'),
        ),
        actions: <Widget>[
//          FlatButton(
//              onPressed: () {
//                setState(() {
//                  Navigator.pop(context);
//                  Navigator.pop(context);
//                  Navigator.pushReplacementNamed(context, '/Login');
//                });
//              },
//              color: Colors.red.shade300,
//              splashColor: Colors.blue,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(30)),
//              child: Text('Cancel',
//                  style: TextStyle(fontSize: 20, color: Colors.black))),
          FlatButton(
              color: Colors.blue.shade300,
              splashColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                var m = cmobile.text;
                var p = cpassword.text;
//                                  Navigator.pop(context);
//                                  Navigator.pop(context);
//                                  Navigator.pushReplacementNamed(context, '/Login');;
                setState(() {
//                  if (centerOPT.text == random.toString()) {
//                    savedPrefrence(m, p);
//                    Navigator.pop(context);
//                    Navigator.pop(context);
//                    Navigator.pushReplacementNamed(context, '/FirstPage');
//                  }
//                  else if (centerOPT.text == ''){
//                    setState(() {
//                      Toast.show("Please Enter OTP.", context,
//                          duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
//                    });
//                  }
//                  else {
//                    Toast.show("OTP dose not match.", context,
//                        duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
//                  }
//                  Navigator.pop(context);
                  savedPrefrence(m, p);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/FirstPage');
                  return true;
                });
              },
              child: Text('Done',
                  style: TextStyle(fontSize: 20, color: Colors.black))),
        ],
      );
      showDialog(context: context, child: dialog);
    });
  }

  void getstarted() {
    var m = cmobile.text;
    var p = cpassword.text;
    setState(() {
      print(m);
      print(p);

      if (m == "" || p == "") {
        setState(() {
          Toast.show("Please fill all the details.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      } else if (!regex2.hasMatch(m)) {
        setState(() {
          Toast.show("Enter valid Mobile number.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      } else {
        setState(() {
          addData(m.toString(), p);
//                      if (addData(m.toString(),p)==true) {
//print('adddata');
//                        if(alertBox()== true)
//                        {
//                          print('alert');
//                          savedPrefrence(m, p);
//                          Navigator.pushReplacementNamed(context, '/FirstPage');
//                        }
//
//                      }
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade50,
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image: AssetImage('images/ride1.jpg'),
//                fit: BoxFit.fill,
//                colorFilter:
//                    ColorFilter.mode(Colors.black87, BlendMode.hardLight))),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Image.asset(
                'images/backgroundgif.gif',
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 75, 15, 0),
              child: TextField(
                textInputAction: TextInputAction.next,
                autofocus: true,
                onSubmitted: (text) {
                  FocusScope.of(context).requestFocus(passwordfocus);
                },
                controller: cmobile,
                style: TextStyle(color: Colors.black, fontSize: 18),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(35.0)),
                    hintText: 'Mobile Number',
                    icon: Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(35.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: TextField(
                textInputAction: TextInputAction.done,
                focusNode: passwordfocus,
                onSubmitted: (text) {
                  getstarted();
                },
                controller: cpassword,
                style: TextStyle(color: Colors.black, fontSize: 18),
                obscureText: hintText1 == "Password" ? _ishidden : false,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(35.0)),
                    hintText: hintText1,
                    suffixIcon: hintText1 == "Password"
                        ? IconButton(
                            icon: _ishidden
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Colors.blue,
                                  )
                                : Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.blue,
                                  ),
                            onPressed: _visibility)
                        : null,
                    hintStyle: TextStyle(color: Colors.black),
                    icon: Icon(
                      Icons.lock,
                      size: 45,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(270, 10, 0, 0),
              child: InkWell(
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Forgetpassword()));
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 15, 100, 0),
              child: Container(
                height: 50,
                width: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient:
                        LinearGradient(colors: [Colors.blue, Colors.cyan])),
                child: Center(
                    child: MaterialButton(
                  splashColor: Colors.black,
                  child: Text("LOGIN", style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    getstarted();
                  },
                  padding: EdgeInsets.fromLTRB(73, 5, 73, 5),
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text(
                    "Don't have an account?  ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: InkWell(
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      });
                    },
                  ),
                ),
              ],
            ),
            Center(
                child: Text(
              msg,
              style: TextStyle(color: Colors.red, fontSize: 20),
            )),
          ],
        ),
      ),
    );
  }
}
