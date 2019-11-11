import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _uname = '', _name = '', _email = '';

var cost0,seatsAvailable0, rideId,startPoint,endPoint,pickUp,driverMobile,startDate,startTime,seatSelected0;
int cost, seatAvailable2,seatSelected2;

class Payment_page extends StatefulWidget {
  Payment_page(cost1,seatsAvailable1,rideId1,startPoint1,endPoint1,pickUp1,driverMobile1,startDate1,startTime1,seatSelected1)
  {
    cost0 = cost1;
    cost = int.parse(cost0);
    seatsAvailable0 = seatsAvailable1;
    seatAvailable2 = int.parse(seatsAvailable0);
    seatSelected0 = seatSelected1;
    seatSelected2 = int.parse(seatSelected0);
    rideId = rideId1;
    startPoint = startPoint1;
    endPoint = endPoint1;
    pickUp = pickUp1;
    driverMobile = driverMobile1;
    startDate = startDate1;
    startTime = startTime1;
  }

  @override
  _Payment_pageState createState() => _Payment_pageState();
}

class _Payment_pageState extends State<Payment_page> {

  int totalAmount = cost, seatAvailable = seatAvailable2, newSeatAvailable, seatSelected= seatSelected2;
  var mobile = '';

  var name = "", email = "",rideId1=rideId ,startPoint1 = startPoint,endPoint1=endPoint,pickUp1 = pickUp,
      driverMobile1=driverMobile,cost1 = cost,startDate1 = startDate, startTime1 = startTime ;
  Razorpay _razorpay;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handelPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handelPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handelExternalWallat);
    _getPrefrence();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  _getPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _uname = pref.getString('saved_uname');
    _name = pref.getString('name');
    _email = pref.getString('email');

    setState(() {
      mobile = _uname.toString();
      name = _name.toString();
      email = _email.toString();
//      print(mobile);
//      print(name);
//      print(email);

    });
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_nptVMEJfz7uRsj',
      'amount': totalAmount * 100,
      'name': 'Prince',
      'description': 'Test Payment',
      'prefail': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void test()
  {
    setState(() {
      print(seatSelected2.toString());
      newSeatAvailable = seatAvailable - seatSelected;
      print(newSeatAvailable.toString());

      print(rideId.toString());
      print(name.toString());
      print(email.toString());
      print(mobile.toString());
      print(startPoint1.toString());
      print(endPoint1.toString());
      print(pickUp1.toString());
      print(cost1.toString());
      print(driverMobile1.toString());
      print(startDate1.toString());
      print(startTime1.toString());

      var url = "https://ridesher.000webhostapp.com/Insert_book_trips.php";
      http.post(url,
          body: {"ride_id": rideId1.toString(), "name": name.toString(), "email": email.toString(),
            "mobile": mobile.toString(), "seat_booked": seatSelected.toString()});

      var url1 = "https://ridesher.000webhostapp.com/Update_AvailableSeats_details.php";
      http.post(url1,
          body: {"seats_available": newSeatAvailable.toString(), "ride_id": rideId1.toString()});

      var url2 = "https://ridesher.000webhostapp.com/Insert_myTrip_booked.php";
      http.post(url2,
          body: {"ride_id": rideId1.toString(), "mobile": mobile.toString(),"start_point": startPoint1.toString(),
            "end_point": endPoint1.toString(),"pick_up": pickUp1.toString(),
            "cost": cost1.toString(),"driver_mobile": driverMobile1.toString(),
            "start_date": startDate1.toString(),"start_time": startTime1.toString()});
    });
  }

  void _handelPaymentSuccess(PaymentSuccessResponse reaponce) {
    setState(() {

      print('============================================='
          '======================================================================================='
          '==================================================');
      test();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/Driver_home_page');
      Fluttertoast.showToast(msg: 'TRIP SUCCESSFULY BOOKED' + reaponce.paymentId);
      });

  }

  void _handelPaymentError(PaymentFailureResponse reaponce) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/Driver_home_page');
    Fluttertoast.showToast(
        msg: 'Error' + reaponce.code.toString() + "-" + reaponce.message);
  }

  void _handelExternalWallat(ExternalWalletResponse reaponce) {
    Fluttertoast.showToast(msg: 'ETERNAL WALLAT' + reaponce.walletName);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController ctotalAmmount = new TextEditingController(text: cost.toString());
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LimitedBox(
              maxHeight: 150.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: ctotalAmmount,
                  keyboardType: TextInputType.number,
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Enter Ammount',
                      suffixIcon: Icon(Icons.attach_money)),
//                  onChanged: (value) {
//                    setState(() {
//                      value = cost.toString();
//                      totalAmount = num.parse(value);
//                    });
//                  },
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: openCheckout,
              child: Text(
                'Checkout',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
