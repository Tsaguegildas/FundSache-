import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/authentifikation/login.dart';
import 'package:fundvgsache/sreens/suchBar.dart';
import 'package:fundvgsache/sreens/user_appBar.dart';
import 'package:sembast/sembast.dart';

import '../models/categorieCard.dart';

class HomeBody extends StatefulWidget {
  final int selectedIndex;
  final String selectedLabel;

  const HomeBody({super.key, required this.selectedIndex, required this.selectedLabel});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    var categoryList = 12;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const UserAppBar(),
              const SizedBox(height: 20),
              const Suchbar(),
              Expanded(
                child: SingleChildScrollView(
                   reverse: false,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          children: [
                            Text(
                              "Categorie",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text("Verloren"),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text("Gefunfen"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6, // Limitez la hauteur du GridView
                        child: GridView.builder(
                          itemCount: categoryList,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20,
                          ),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 24,
                          ),
                          itemBuilder: (context, index) {
                            return CategoryCard();
                          },
                        ),
                      ),
                      // Card(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(16.0),
                      //     child: Column(
                      //       children: [
                      //         Text('ausgewälte Index : ${widget.selectedIndex}'),
                      //         Text('ausgewälte Label: ${widget.selectedLabel}'),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipOval(
                      child: Image.asset(
                        'lib/assets/moi1.png',
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _createDrawerItem(context, 'Mein Profil'),
            _createDrawerItem(context, 'Meine Anzeigen'),
            _createDrawerItem(context, 'Nachrichten'),
            _createDrawerItem(context, 'Hilfe'),
            _createDrawerItem(context, 'Abmelden', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(BuildContext context, String title, [VoidCallback? onTap]) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepPurple.withOpacity(.3),
      ),
      child: ListTile(
        title: Text(title),
        onTap: onTap ?? () {},
      ),
    );
  }
}

