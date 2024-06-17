import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("object Gildas ");
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ),
          ]
        ),
        child: Column(
          children: [
            Container(
              child: Image.asset(
                'lib/assets/img_4.png',
                width: 100,
                height: 95,
                fit: BoxFit.cover,
              ),
            ),
            const  SizedBox(height: 10),
             const Text("Name des Objekts", style: TextStyle(fontFamily: 'RobotoMono' ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const  Text("verfugbar",style: TextStyle(fontSize: 10,color: Colors.red,fontWeight:FontWeight.bold, fontFamily: 'RobotoMono' ),),
                ),
               const  SizedBox(height: 30),
                Container(
                  padding: const  EdgeInsets.only(right: 10),
                  child: const Text("10/04/2024",style: TextStyle(fontSize: 10,color: kPrimaryColor,fontWeight:FontWeight.bold,),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
