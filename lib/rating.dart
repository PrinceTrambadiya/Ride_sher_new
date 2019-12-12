import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Trips.dart';
String _uname = '';

var driver_mobile;
var mobile;
class rating extends StatefulWidget {

  var driver_mobile1;

   rating(var driver_mobile1) {
    this.driver_mobile1 = driver_mobile1;
    driver_mobile = driver_mobile1;
  }
  @override
  _ratingState createState() => _ratingState();
}


class _ratingState extends State<rating> {
  double _rating;
  TextEditingController cFeedBack = new TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    print(driver_mobile);
    _getPrefrence();
    super.initState();
  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    mobile = _uname.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Review and Ratings'),
      ),
      body: Container(
        color: Colors.blue.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: RatingBar(
                onRatingChanged: (rating){
                  setState(() {
                    _rating = rating;
                    print(_rating);
                  });
                },
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                halfFilledIcon: Icons.star_half,
                isHalfAllowed: true,
                filledColor: Colors.deepOrange,
                emptyColor: Colors.black,
                halfFilledColor: Colors.orangeAccent,
                size: 48,
              ),
            ),
           // SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,15,10,15),
              child: Container(
                child: TextField(
                  controller: cFeedBack,
                  minLines: 5,
                  maxLines: 15,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Write your Feedback here(Optional)',
                    filled: true,
                    fillColor: Color(0xFFDBEDFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: addData,
              child: Text("SUBMIT",style: TextStyle(fontWeight: FontWeight.bold),),
              color: Colors.yellow,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            )
          ],
        ),
      ),
    );
  }

void addData() {

  setState(() {
      var feedBck = cFeedBack.text;
  print(_rating.toString());
  print(feedBck.toString());
  print(driver_mobile.toString());
  print(mobile.toString());
    var url = "https://ridesher.000webhostapp.com/feedback.php";
    http.post(url, body: {
      "rating": _rating.toString(),
      "feedback": feedBck.toString(),
      "driver_mobile": driver_mobile.toString(),
      "rider_mobile": mobile.toString()
    });
  });
  Navigator.pop(context);
  Navigator.pop(context);
 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Trips()));
                        
  }
  
}
