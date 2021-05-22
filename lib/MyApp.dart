import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  String ten;
  int tuoi;
  MyApp({this.ten, this.tuoi});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  /**
    1. initState được gọi đầu tiên sau contructor
    2. build() gọi lại đi gọi lại nhiều khi state thay đổi
    3. dispose() gọi khi thay đổi màn hình
   **/
  String _email; // đây là state
  final emailEdit =
      TextEditingController(); // theo dõi sự thay đổi giá trị trên textflied
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print('run init');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();

    print('run dispose');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('bg mode');
    } else if (state == AppLifecycleState.resumed) {
      print('Fg mode');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('run build');

    // TODO: implement build
    return MaterialApp(
      title: 'fisrt scan ',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // giữa theo dọc
            crossAxisAlignment: CrossAxisAlignment.center, // giữa theo ngang
            children: <Widget>[
              Text(
                '${this._email}',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 40),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: emailEdit,
                  onChanged: (text) {
                    this.setState(() {
                      this._email = text;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(30))),
                    labelText: 'enter',
                  ),
                ),
              ),
              Text(
                '${widget.ten}----${widget.tuoi}',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 40),
              ),
              Text(
                '${widget.ten}----${widget.tuoi}',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 40),
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
