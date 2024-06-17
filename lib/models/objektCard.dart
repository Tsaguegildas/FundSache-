import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/models/lostItem.dart';

import '../sreens/details_page.dart';

class ObjektCard extends StatelessWidget {
  final LostItems itemlos;

  const ObjektCard({super.key, required this.itemlos});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("object Gildas");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(lostItem: itemlos,),
          ),
        );
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
          ],
        ),
        child: Column(
          children: [
            Container(
              child: itemlos.itemBild != null
                  ? Image.asset(
                itemlos.itemBild.toString(),
                width: 100,
                height: 95,
                fit: BoxFit.cover,
              )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 10),
            Text(
              itemlos.itemName,
              style: const TextStyle(fontFamily: ''),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    itemlos.itemStatus,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    itemlos.itemDateFund,
                    style: const TextStyle(
                      fontSize: 10,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
