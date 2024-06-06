import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';

class Suchbar extends StatelessWidget {
  const Suchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38, blurRadius: 4)
                      ]),
                  child: const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Icon(Icons.search),
                    ),
                  )),
            ),
             const SizedBox(width: 10,),
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                color: Colors.white,
                onPressed: () {},
                icon:  const Icon(Icons.sort_by_alpha),
              ),
            ),
          ],
        )
      ],
    );
  }
}
