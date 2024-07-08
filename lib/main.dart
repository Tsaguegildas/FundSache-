import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fundvgsache/service/authService.dart';
import 'package:fundvgsache/sreens/authentifikation/login.dart';
import 'package:fundvgsache/sreens/authentifikation/signup.dart';
import 'package:fundvgsache/sreens/homesreens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'model/meinUser.dart';


 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FundSache',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  LoginScreen(),
      ),
    );
  }
}