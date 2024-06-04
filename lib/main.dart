import 'package:flutter/material.dart';
import 'package:fundvgsache/sreens/authentifacation/signup.dart';
import 'package:fundvgsache/sreens/home.dart';
import 'package:fundvgsache/sreens/homesreens.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FundSache',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Homesreen(),
    );
  }
}