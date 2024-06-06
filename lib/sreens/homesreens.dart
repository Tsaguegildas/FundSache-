import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/homeBody.dart';
class Homesreen extends StatefulWidget {

  @override
  State<Homesreen> createState() => _HomesreenState();
}

class _HomesreenState extends State<Homesreen> {
  int i=1;
  int selectIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Search Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Profile Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Settings Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: kBGColor,
      body: const HomeBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
        icon: Icon(Icons.keyboard_double_arrow_left),
    label: 'Zurück',
    ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

        ],
        currentIndex: selectIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,

      ),


    );
  }
}
