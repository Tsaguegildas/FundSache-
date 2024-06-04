import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/suchBar.dart';
import 'package:fundvgsache/sreens/user_appBar.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              UserAppBar(),
              SizedBox(height: 20,),
              Suchbar(),
              SizedBox(height: 10,),

            ],
          ),
        ),
      ),
      drawer: Drawer(),
    );
  }
}
