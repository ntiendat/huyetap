import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'Transaction.dart';
import 'package:hive/hive.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart' as intl;

import 'event.dart';
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
