import 'package:flutter/material.dart';
import 'package:fundvgsache/sreens/authentifikation/login.dart';
import 'package:fundvgsache/sreens/homesreens.dart';
import 'package:provider/provider.dart';

import '../model/meinUser.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);
    //  return entweder Home oder Authentikation Widget
    if(user==null){
      return LoginScreen()  ;
    }else{
      return Homescreen();
    }
  }
}
