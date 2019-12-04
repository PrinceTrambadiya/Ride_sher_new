import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatefulWidget {
  @override
  _ContactusState createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text("Contactus"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Card(color: Colors.green.shade300,
              child: ListTile(
                leading: Icon(Icons.call),
                title: Text('Call us'),
                subtitle: Text('18001801800'),
                onTap: () => launch("tel://18001801800"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Card(color: Colors.red.shade300,
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('Email us'),
                subtitle: Text('ridesher@gmail.com'),
                onTap: () => launch('mailto:ridesher@gmail.com?subject=Paisa%20nu%20gaplu&body='),
              ),
            ),
          )
        ],
      ),
    );
  }
}
