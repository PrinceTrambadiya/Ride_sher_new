// import 'package:flutter/material.dart';
// import 'package:map_demo/states/app_state.dart';
// import 'package:provider/provider.dart';
// import 'screens/home.dart';

// void main() {
//   return runApp(MultiProvider(providers: [
//     ChangeNotifierProvider.value(value: AppState(),)
//   ],
//     child: MyApp(),));
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Ridesher',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'RideSher'),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FirstPage.dart';
import 'GoogleMap/app_state.dart';
import 'Login.dart';
import 'Forgetpassword.dart';
import 'welcome.dart';
import 'Driver_details.dart';
import 'Add_Trip.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppState(),
        )
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  var page;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)))),
      //home: Login(),
      home: Welcome(),
      //home: call(),
      routes: <String, WidgetBuilder>{
        '/FirstPage': (BuildContext context) => new FirstPage(),
        '/Login': (BuildContext context) => new Login(),
        //'/ConfirmPassword': (BuildContext context) => new ConfirmPassword(),
        '/Forgetpassword': (BuildContext context) => new Forgetpassword(),
        '/driver_details': (BuildContext context) => new driver_details(),
        '/Add_Trip': (BuildContext context) => new Add_Trip(),

      },
    );
  }
}
