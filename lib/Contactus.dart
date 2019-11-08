import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatefulWidget {
  @override
  _ContactusState createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contactus"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.call),
            title: Text('Call us'),
            subtitle: Text('18001801800'),
            onTap: () => launch("tel://18001801800"),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email us'),
            subtitle: Text('ridesher@gmail.com'),
            onTap: () => launch('mailto:ridesher@gmail.com?subject=Paisa%20nu%20gaplu&body='),
          )
        ],
      ),
    );
  }
}
