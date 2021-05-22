import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return MaterialApp(
      title: 'fisrt scan ',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // giữa theo dọc
            crossAxisAlignment: CrossAxisAlignment.center, // giữa theo ngang
            children: <Widget>[
              Text(
                DateFormat("yyyy/MM/dd").format(now),
                // textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   String ten;
//   int tuoi;
//   MyApp({this.ten, this.tuoi});
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//         title: 'Trang home',
//         home: Scaffold(
//           body: Center(
//             child: Text(
//               '${this.ten}--${tuoi}',
//               textDirection: TextDirection.ltr,
//               style: TextStyle(fontSize: 40),
//             ),
//           ),
//         ));
//   }
// }
