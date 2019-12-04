import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutus extends StatefulWidget {
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(color: Colors.blue.shade100,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: Container(width: 400,color: Colors.grey.shade300,
                child: Text('Uber Technologies, Inc., commonly known as Uber, is an American multinational ride-hailing company offering services that include peer-to-peer ridesharing, ride service hailing, food delivery, and a micromobility system with electric bikes and scooters. The company is based in San Francisco and has operations in over 785 metropolitan areas worldwide.[2] Its platforms can be accessed via its websites and mobile apps.'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: GestureDetector(onTap: _launchURLGIT,
                child: Card(color: Colors.grey.shade300,
                  child: Container(width: 400,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Image.asset('images/github1.png',width: 40,color: Colors.deepOrange,),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                              child: Text('Github',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange),),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Text('Find codes to all the file in our github repositroy.'),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Text('Contributors',style: TextStyle(fontSize: 20,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: GestureDetector(onTap: _launchURLSUNNYGIT,
                child: Card(color: Colors.grey.shade300,
                  child: Container(
                    width: 400,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: CircleAvatar(backgroundImage: AssetImage('images/sunny.jpeg',),radius: 35,),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text('Sunny Patel',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.deepOrange),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text('Flutter Developer',style: TextStyle(fontSize: 12),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text('Ahmedabad, India'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: GestureDetector(onTap: _launchURLPRINCEGIT,
                child: Card(color: Colors.grey.shade300,
                  child: Container(
                    width: 400,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: CircleAvatar(backgroundImage: AssetImage('images/prince.jpeg',),radius: 35,),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text('Prince Trambadiya',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.deepOrange),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text('Flutter Developer',style: TextStyle(fontSize: 12),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text('Ahmedabad, India'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: GestureDetector(onTap: _launchURLYASHGIT,
                child: Card(color: Colors.grey.shade300,
                  child: Container(
                    width: 400,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: CircleAvatar(backgroundImage: AssetImage('images/yash.jpeg',),radius: 35,),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text('Yash Savsani',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.deepOrange),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text('Flutter Developer',style: TextStyle(fontSize: 12),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text('Ahmedabad, India'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

_launchURLGIT() async{
  const url = "https://github.com/PrinceTrambadiya/Ride_sher_new";
  if (await canLaunch(url)){
    await launch(url);
  }
  else
    {
      throw 'Could not launch $url';
    }
}

_launchURLSUNNYGIT() async{
  const url = "https://github.com/spworld1998";
  if (await canLaunch(url)){
    await launch(url);
  }
  else
  {
    throw 'Could not launch $url';
  }
}

_launchURLPRINCEGIT() async{
  const url = "https://github.com/PrinceTrambadiya";
  if (await canLaunch(url)){
    await launch(url);
  }
  else
  {
    throw 'Could not launch $url';
  }
}

_launchURLYASHGIT() async{
  const url = "https://github.com/Savyash";
  if (await canLaunch(url)){
    await launch(url);
  }
  else
  {
    throw 'Could not launch $url';
  }
}

