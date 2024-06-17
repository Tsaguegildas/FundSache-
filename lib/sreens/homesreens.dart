import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/homeBody.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectIndex = 1;
  final List<String> labels = ['Zurück', 'Home', 'Profile'];

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: HomeBody(
        selectedIndex: selectIndex,
        selectedLabel: labels[selectIndex],
      ),

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
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
