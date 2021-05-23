import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'Transaction.dart';
import 'package:hive/hive.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'event.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
// 1. ListView(children:<Widget>[]) => load 1 lần hết các phần tử )
//     // 2. ListView(itemBuilder:...) => load những phần tử onscraen)
// Cách 1
// class TransList extends StatelessWidget {
//   List<Transaction> transactions;
//   TransList({this.transactions});
//   List<Widget> _buildTrans() {
//     int index = 0;
//     return transactions.map((e) {
//       index++;
//       return Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         color: index % 2 == 0 ? Colors.indigo : Colors.red,
//         elevation: 10,
//         child: ListTile(
//           leading: Icon(Icons.access_alarm_sharp),
//           title: Text(e.content),
//           subtitle: Text('${e.price}'),
//           onTap: () {
//             print(e.toString());
//           },
//         ),
//       );
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 1. ListView(children:<Widget>[]) => load 1 lần hết các phần tử )
//     // 2. ListView(itemBuilder:...) => load những phần tử onscraen)
//     return Container(
//       height: 500,
//       child: ListView(
//         children: this._buildTrans(),
//       ),
//     );
//     return Column(
//       children: this._buildTrans(),

//     );
//   }
// }
// 1. ListView(children:<Widget>[]) => load 1 lần hết các phần tử )
//     // 2. ListView(itemBuilder:...) => load những phần tử onscraen)
//cách 2

class ListTrans extends StatefulWidget {
  List<Transaction> transactions = new List<Transaction>();
  ListTrans({Key key, this.transactions}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ListTrans();
  }
}

Transaction transaction = Transaction(sys: 0, dia: 0, pulse: 0, date: '');

class _ListTrans extends State<ListTrans> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); //Toast
  final _contentController = TextEditingController();
  final _priceController = TextEditingController();
  final _pulseController = TextEditingController();
  List<Transaction> transactions;

  _delete(int index) async {
    setState(() {
      transactions.removeAt(index);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', jsonEncode(transactions));
  }

  Color _setcolor(Transaction tran) {
    if (tran.sys >= 140 || tran.dia >= 90) {
      return Colors.red;
    } else {
      if ((tran.sys >= 120 || tran.dia >= 80)) {
        return Colors.red[100];
      } else {
        if ((tran.sys >= 100)) {
          return Colors.green[100];
        } else {
          return Colors.yellow[300];
        }
      }
    }
  }

  _insertTrans2(int index) {
    if (transaction.sys.isNaN ||
        transaction.dia.isNaN ||
        transaction.pulse.isNaN) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Chưa nhập đúng'),
        duration: Duration(seconds: 3),
      ));
      return;
    }
    transaction.date = transactions[index].date;
    transactions[index] = transaction;

    transactions.sort((a, b) {
      var adate = a.date;
      var bdate = b.date;
      return bdate.compareTo(
          adate); //to get the order other way just switch `adate & bdate`
    });
  }

  void _showModel1(int index) {
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
                        transaction.pulse = int.tryParse(text) ?? 0;
                      });
                    },
                    decoration: InputDecoration(labelText: 'PULSE :'),
                  ),
                  FlatButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        this._insertTrans2(index);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Sửa',
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
            ),
          );
        });
  }

  ListView _buildTrans() {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: _setcolor(transactions[index]),
                elevation: 10,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(10, 25, 10, 25)),
                    transactions[index].sys > 120
                        ? Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.accessibility,
                            color: Colors.green,
                          ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    Column(
                      children: [
                        Text('SYS :  ',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 20),
                            textDirection: TextDirection.ltr),
                        Text(
                          'DIA : ',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'PULSE : ',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${transactions[index].sys}',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          ' ${transactions[index].dia}',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          ' ${transactions[index].pulse}',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${transactions[index].date}'),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        InkWell(
                          onTap: () {
                            _delete(index);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.black54,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     _showModel1(index);
                        //   },
                        //   child: Icon(
                        //     Icons.edit,
                        //     color: Colors.black45,
                        //   ),
                        // ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                      ],
                    ))
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    this.transactions = widget.transactions;
    print('build ');
    return Container(
        height: MediaQuery.of(context).size.height * 0.80,
        child: this._buildTrans());
  }
}

class TransList extends StatelessWidget {
  List<Transaction> transactions;
  TransList({this.transactions});

  ListView _buildTrans() {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: transactions[index].sys > 120
                    ? Colors.red[100]
                    : Colors.green[200],
                elevation: 10,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(10, 25, 10, 25)),
                    transactions[index].sys > 120
                        ? Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.accessibility,
                            color: Colors.green,
                          ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    Column(
                      children: [
                        Text('SYS :  ',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 20),
                            textDirection: TextDirection.ltr),
                        Text(
                          'DIA : ',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'PULSE : ',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${transactions[index].sys}',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          ' ${transactions[index].dia}',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          ' ${transactions[index].pulse}',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${transactions[index].date}'),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        InkWell(
                          onTap: () {
                            print('delete');
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                      ],
                    ))
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // 1. ListView(children:<Widget>[]) => load 1 lần hết các phần tử )
    // 2. ListView(itemBuilder:...) => load những phần tử onscraen)
    return Container(height: 500, child: this._buildTrans());
  }
}
