import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Transaction.dart';
import 'TransList.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyApp extends StatefulWidget {
  // List<Transaction> transactions = new List<Transaction>();
  // MyApp({Key key, this.transactions}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // print(222222);
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // _MyAppState(List<Transaction> a) {
  //   this._transactions = a;
  // }
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); //Toast

  final _contentController = TextEditingController();
  final _priceController = TextEditingController();
  final _pulseController = TextEditingController();
  int a = 0;
  Transaction transaction = Transaction(sys: 0, dia: 0, pulse: 0, date: '');
  List<Transaction> _transactions = new List<Transaction>();

  void _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var json = '[]';

    var json = (prefs.getString('key') ?? '[]');
    setState(() {
      _transactions = parsePhotos(json);
    });
    // await prefs.setString('key', jsonEncode(_transactions));
  }

  List<Transaction> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<Transaction>((json) => Transaction.fromJson(json))
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    print(this._transactions);
    super.initState();
    this._getData();

    // print('-----------${_loadAStudentAsset[]}');
  }

  void _insertTrans() async {
    if (transaction.sys.isNaN ||
        transaction.dia.isNaN ||
        transaction.pulse.isNaN) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Chưa nhập đúng'),
        duration: Duration(seconds: 3),
      ));
      return;
    }
    DateTime now = new DateTime.now();
    transaction.date = DateFormat("hh:mm:ss dd/MM").format(now);
    _transactions.add(transaction);

    _transactions.sort((a, b) {
      var adate = a.date;
      var bdate = b.date;
      return bdate.compareTo(
          adate); //to get the order other way just switch `adate & bdate`
    });

    setState(() {
      transaction = Transaction(sys: 0, pulse: 0, dia: 0, date: '');
    });
    _contentController.text = '';
    _priceController.text = '';
    _pulseController.text = '';
    // print('${jsonEncode(_transactions)}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', jsonEncode(_transactions));
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(_transactions.toString()),
      duration: Duration(seconds: 3),
    )); //Toast
    FocusScope.of(context).requestFocus(new FocusNode()); // tắt bàn phím ảo
  }

  void _showModel() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  TextField(
                    controller: _contentController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {
                        DateTime now = new DateTime.now();
                        transaction.date = DateFormat("hh:s dd/MM").format(now);
                        transaction.sys = int.tryParse(text) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'SYS :',
                    ),
                  ),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {
                        DateTime now = new DateTime.now();
                        transaction.date = DateFormat("hh:s dd/MM").format(now);
                        transaction.dia = int.tryParse(text) ?? 0;
                      });
                    },
                    decoration: InputDecoration(labelText: 'DIA :'),
                  ),
                  TextField(
                    controller: _pulseController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {
                        DateTime now = new DateTime.now();
                        transaction.date = DateFormat("hh:s dd/MM").format(now);
                        transaction.pulse = int.tryParse(text) ?? 0;
                      });
                    },
                    decoration: InputDecoration(labelText: 'PULSE :'),
                  ),
                  FlatButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        this._insertTrans();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Thêm',
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(4);
    a++;
    print('buill lại thứ ${a}');
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            this._showModel();
          },
        ),
        appBar: AppBar(
          title: Center(
            child: Text('Lịch sử đo huyết áp '),
          ),
          // actions: <Widget>[
          //   IconButton(
          //       icon: Icon(Icons.add),
          //       onPressed: () {
          //         this._insertTrans();
          //         print('add tap !! ');
          //       })
          // ],
        ),
        key: _scaffoldKey, //Toast
        body: SafeArea(
          minimum: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // giữa theo dọc
                crossAxisAlignment:
                    CrossAxisAlignment.center, // giữa theo ngang
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  // FlatButton(
                  //     color: Theme.of(context).accentColor,
                  //     onPressed: () {
                  //       this._showModel();
                  //     },
                  //     child: Text(
                  //       'Mua',
                  //       style: TextStyle(
                  //           color: Colors.white, fontFamily: 'Dancing_Script'),
                  //     )),
                  // TransList(transactions: this._transactions),
                  ListTrans(
                    transactions: this._transactions,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
