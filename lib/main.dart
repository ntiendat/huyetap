import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/widgets.dart';
import 'Transaction.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'MyApp3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox<Transaction>('ts');
  return runApp(MaterialApp(
    title: 'myapp',
    theme: ThemeData(
        primaryColor: Colors.green[300], accentColor: Colors.pink[500]),
    home: MyApp(),
  ));
}
