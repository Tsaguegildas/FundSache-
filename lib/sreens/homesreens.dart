import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/home_inhalt.dart';
class Homesreen extends StatefulWidget {

  @override
  State<Homesreen> createState() => _HomesreenState();
}

class _HomesreenState extends State<Homesreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: HomeBody(),

    );
  }
}
