import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

var cost0,seatsAvailable;
int cost, newSeatas0, newSeatas1, newSeatas;

class Payment_page extends StatefulWidget {
  Payment_page(cost1,seatsAvailable1)
  {
    cost0 = cost1;
    seatsAvailable = seatsAvailable1;
    cost = int.parse(cost0);
  }

  @override
  _Payment_pageState createState() => _Payment_pageState();
}

class _Payment_pageState extends State<Payment_page> {

  int totalAmount = cost;
  Razorpay _razorpay;
  var newSeatsAvailable1 = seatsAvailable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handelPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handelPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handelExternalWallat);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
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

//  void test()
//  {
//    setState(() {
//      newSeatsAvailable = newSeatsAvailable1 - 1;
//      print(newSeatsAvailable);
//    });
//  }

  void _handelPaymentSuccess(PaymentSuccessResponse reaponce) {
    setState(() {

      print('============================================='
          '======================================================================================='
          '==================================================');
     // newSeatsAvailable = seatsAvailable - 1;
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/Driver_home_page');
      Fluttertoast.showToast(msg: 'SUCCESS' + reaponce.paymentId);
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
