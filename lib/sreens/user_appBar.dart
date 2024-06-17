import 'package:flutter/material.dart';
import '../konztante.dart';
import 'package:badges/badges.dart' as badges;
class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.dashboard, color: kPrimaryColor,),
            ),
          ),
        ),
        const Column(
          children: [
            Text("FundSache"),
            Text(
              " Wilkommen",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: kPrimaryColor,
            child: Badge(
              backgroundColor: Colors.red,
              child: InkWell(
                onTap: (){
                  print("object Gildas");
                },
                child: const Icon(Icons.notifications,color: Colors.white,),
              ), label: Text('5'),
            ),

        ),
      ],
    );
  }
}
