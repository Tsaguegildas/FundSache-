import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/authentifikation/login.dart';
import 'package:fundvgsache/sreens/suchBar.dart';
import 'package:fundvgsache/sreens/user_appBar.dart';
import 'package:sembast/sembast.dart';

import '../models/lostItem.dart';
import '../models/objektCard.dart';

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
              SizedBox(height: 10),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      sliver: SliverToBoxAdapter(
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
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 24,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            var itemlos = LostItems(
                              itemId: 1,
                              itemName: "Tasche",
                              itemMarque: "addidas",
                              itemBeschreibung: "Ein Schlüsselbund mit 3 Schlüsseln und einem Anhänger",
                              itemLocationFund: "Bahnhof",
                              itemDateFund: "2024-06-04",
                              finderId: 101, // ID des Benutzers, der den Gegenstand gefunden hat
                              itemStatus: "gefunden",
                              itemBild: "lib/assets/img_6.png",
                            );
                            return ObjektCard(itemlos: itemlos);
                          },
                          childCount: categoryList,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text('ausgewälte Index : ${widget.selectedIndex}'),
                              Text('ausgewälte Label: ${widget.selectedLabel}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
