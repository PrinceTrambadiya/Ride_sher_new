import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'ConfirmPassword.dart';
import 'package:toast/toast.dart';

class Forgetpassword extends StatefulWidget {
  @override
  _ForgetpasswordState createState() => _ForgetpasswordState();
}

var data;
Pattern pattern2 = r'^[789]\d{9}$';

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController cmobile = new TextEditingController();
  TextEditingController centerOPT = new TextEditingController();
  RegExp regex2 = new RegExp(pattern2);
  var msg = '';
  var rng = new Random();
  var random;
  var fatchmobile;


  Future<void> verifyMobile(mobile) async {
    final response = await http
        .post("https://ridesher.000webhostapp.com/forgotPassOTP.php", body: {
      "mobile": mobile,
    });

    data = json.decode(response.body);
    var typemobile = mobile;
    fatchmobile = data[0]['mobile'];

//    print(data);
//    print(fatchPass);
//    print(typePass);

    if (data.length == 0) {
      setState(() {
        msg = 'Enter Again';
      });
    }

    if (fatchmobile != '' && typemobile != '') {
      if (fatchmobile == typemobile) {
        setState(() {
          alertBox();
          //savedPrefrence(mobile, typemobile);
//          Navigator.pop(context);
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => ConfirmPassword(fatchmobile)));
        });
        return true;
      } else if (fatchmobile != typemobile) {
        setState(() {
          msg = 'Enter Again';
        });
        return false;
      }
    } else {
      setState(() {
        msg = 'Enter Again';
      });
    }
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
    setState(() {
         validUser();
//      random = rng.nextInt(1000000);
//      print(random);
      AlertDialog dialog = new AlertDialog(
        backgroundColor: Colors.green.shade200,
        shape: RoundedRectangleBorder(
            side: BorderSide(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(30)),
        title: Text('Verifaction'),
        content:
            TextField(
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
                  if (centerOPT.text == random.toString()) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmPassword(fatchmobile)));
                  }
                  else if (centerOPT.text == ''){
                    setState(() {
                      Toast.show("Please Enter OTP.", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
                    });
                  }
                  else {
                    Toast.show("OTP dose not match.", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
                  }
//                  Navigator.pop(context);
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => ConfirmPassword(fatchmobile)));
                });

              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: Colors.blue.shade300,
              child: Text('Done',
                  style: TextStyle(fontSize: 20, color: Colors.black))),
        ],
      );
      showDialog(context: context, child: dialog);

    });
  }

  var hintText = 'Enter Confirm Password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrange,
        title: Text('Forget Password'),
      ),
      body: Container(color: Colors.blue.shade50,

        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (text){
                  otp(); //otp() is function
                },
                controller: cmobile,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Enter Mobile Number',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: MaterialButton(
                onPressed: () {
                  otp(); //otp() is function

                },
                child: Text(
                  'Generate OTP',
                  style: TextStyle(fontSize: 20),
                ),
                padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
            Text(
              msg,
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
  void otp()
  {
    setState(() {
      var m = cmobile.text;
      if (regex2.hasMatch(m) && m != "") {
        verifyMobile(m);
      } else {
        setState(() {
          msg = 'Enter Again';
        });
      }
      // Navigator.pushReplacementNamed(context, '/ConfirmPassword');
    });
  }
}
