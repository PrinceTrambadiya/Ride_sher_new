import 'package:flutter/material.dart';
import 'Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _uname = '', _name = '', _email = '',_carName='',_carNumberPlate='',_dob='',_driving_licence='',_rcbook='';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override

  var mobile = '';

  var name = "", email = "", dob = "", address = "",carName='',carNumberPlate='',DriverLicence='',rcBook='';

  @override
  void initState() {
    // TODO: implement initState
    _getPrefrence();
    super.initState();
  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    _name = pref.getString('name');
    _email = pref.getString('email');
    _carName = pref.getString('CarName');
    _carNumberPlate = pref.getString('CarNumberPlate');
    _dob = pref.getString('dob');
    _driving_licence = pref.getString('DriverLicence');
    _rcbook = pref.getString('RcNumber');
    setState(() {
      mobile = _uname.toString();
      name = _name.toString();
      email = _email.toString();
      carName = _carName.toString();
      carNumberPlate = _carNumberPlate.toString();
      dob = _dob.toString();
      DriverLicence = _driving_licence.toString();
      rcBook = _rcbook.toString();
//      print(mobile);
//      print(name);
//      print(email);
//      print(carName);
//      print(carNumberPlate);
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 9, 9),
              child: Container(
                //color: Colors.yellow,
                  child: Column(children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                      child: Text(
                        'User',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.message,
                            color: Colors.blueAccent,
                          ),
                          onPressed: message,
                          iconSize: 35,
                        ),
                        MaterialButton(
                            onPressed: () {
                            },
                            child: CircleAvatar(
                              backgroundImage: AssetImage('images/logo_.jpg'),
                              radius: 50,
                            )),
                        IconButton(
                          icon: Icon(
                            Icons.call,
                            color: Colors.blueAccent,
                          ),
                          onPressed: call,
                          iconSize: 35,
                        )
                      ],
                    ),
                  ])),
            ),
            Divider(
              height: 10,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Driver Licence',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DriverLicence,
                      style: TextStyle(fontSize: 16),
                    ),
//                    Text(
//                      'Developer.#Enterpreneur #YouTuber',
//                      style: TextStyle(fontSize: 16),
//                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 10,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Car Name',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(carName),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Car NamePlate',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(carNumberPlate),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                  'RC Number',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(rcBook),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Mobile',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(mobile),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(email),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Date Of Birth',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(dob),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: press,
//        child: Icon(Icons.person_add),
//        backgroundColor: Colors.black,
//      ),
    );
  }

//  void press() {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
//  }
  void message() {}
  void call() {}
  void photo() {}

}










//            Padding(
//              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//              child: Container(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          '1.5K',
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold, fontSize: 20),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//                          child: Text(
//                            'Posts',
//                            style: TextStyle(fontSize: 16),
//                          ),
//                        ),
//                      ],
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          '2.5K',
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold, fontSize: 20),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//                          child: Text(
//                            'Followers',
//                            style: TextStyle(fontSize: 16),
//                          ),
//                        ),
//                      ],
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          '10K',
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold, fontSize: 20),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//                          child: Text(
//                            'Comments',
//                            style: TextStyle(fontSize: 16),
//                          ),
//                        ),
//                      ],
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          '1.2K',
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold, fontSize: 20),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//                          child: Text('Following'),
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
//            ),
//            Divider(
//              height: 10,
//              color: Colors.grey,
//            ),
