import 'package:flutter/material.dart';

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
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
              'Uber is an American multinational transportation company based in San Francisco that offers peer-to-peer ridesharing, but which has also extended into other areas, such as food delivery (Uber Eats), bicycle sharing, etc. Its innovative concept allowed it to reach a huge scale of operations in a record time – since it was founded in March 2009, it gained presence in about 800 metropolitan areas, becoming an essential service for millions of urban dwellers worldwide. Essays on this topic might explore in greater detail the innovative operation principle, the technology, business ethics, expansion model, etc. When writing the essay, be careful to assemble a sound outline, write a strong introduction and conclusion, but also watch your style and grammar.',
              textAlign: TextAlign.justify,
              textDirection: TextDirection.ltr,
              ),
        ),
      ),
    );
  }
}
