import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/authentifikation/login.dart';
import 'package:fundvgsache/sreens/homesreens.dart';
import 'package:fundvgsache/sreens/itemFormular.dart';
import 'package:fundvgsache/sreens/suchBar.dart';
import 'package:fundvgsache/sreens/user_appBar.dart';
import 'package:sembast/sembast.dart';

import '../models/lostItem.dart';
import '../models/objektCard.dart';
import '../service/authService.dart';

class HomeBody extends StatefulWidget {
  final int selectedIndex;
  final String selectedLabel;

  HomeBody(
      {super.key, required this.selectedIndex, required this.selectedLabel});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final AuthService _auth = AuthService();
  // final AuthService _auth= AuthService();
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                              itemBeschreibung:
                                  "Ein Schlüsselbund mit 3 Schlüsseln und einem Anhänger",
                              itemLocationFund: "Bahnhof",
                              itemDateFund: "2024-06-04",
                              finderId:
                                  101, // ID des Benutzers, der den Gegenstand gefunden hat
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
                              Text(
                                  'ausgewälte Index : ${widget.selectedIndex}'),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemFormPage(),
            ),
          );
        },
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        tooltip: 'Enregistrer l\'item',
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
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.withOpacity(.3),
              ),
              child: ListTile(
                title: Text("Mein Profil"),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.withOpacity(.3),
              ),
              child: ListTile(
                title: Text("Meine Anzeigen"),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.withOpacity(.3),
              ),
              child: ListTile(
                title: Text("Nachrichten"),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.withOpacity(.3),
              ),
              child: ListTile(
                title: Text("Hilfe"),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.withOpacity(.3),
              ),
              child: ListTile(
                  title: Text("Abmelden"),

                  onTap: () async {

                    await _auth.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: DefaultTabController(
                            length: 4,
                            child: LoginScreen(),
                          ),
                        ),
                      ),
                    );
                  }
                  // async{
                  //
                  //   await _auth.signOut();
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ItemFormPage(),
                  //     ),
                  //   );
                  // },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(BuildContext context, String title,
      [VoidCallback? onTap]) {
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
