import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  int sys;
  int dia;
  int pulse;
  String date;

  Transaction({this.sys, this.dia, this.pulse, this.date});

  @override
  String toString() {
    // TODO: implement toString
    return '${this.sys}---${this.dia}';
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      sys: json['sys'] as int,
      dia: json['dia'] as int,
      pulse: json['pulse'] as int,
      date: json['date'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'sys': sys,
      'dia': dia,
      'pulse': pulse,
      'date': date,
    };
  }
}
