import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/authentifikation/login.dart';
import 'package:fundvgsache/sreens/homesreens.dart';
import 'package:fundvgsache/sreens/itemFormular.dart';
import 'package:fundvgsache/sreens/suchBar.dart';
import 'package:fundvgsache/sreens/userProfile.dart';
import 'package:fundvgsache/sreens/user_appBar.dart';
import '../service/authService.dart';
import 'details_page.dart';
import '../models/lostItem.dart'; // Import the model

class HomeBody extends StatefulWidget {
  final int selectedIndex;
  final String selectedLabel;

  HomeBody({super.key, required this.selectedIndex, required this.selectedLabel});

  @override

  State<HomeBody> createState() => _HomeBodyState();
}


class _HomeBodyState extends State<HomeBody> {
  void initState() {
    super.initState()
    /////////// ic les e
    ;
  }
  Stream<QuerySnapshot> get lostItems => FirebaseFirestore.instance.collection('LostItem').snapshots();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const UserAppBar(),
              const SizedBox(height: 20),
              const Suchbar(),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Kategorie",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text("Verloren"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Gefunden"),
                      ),
                    ],
                  ),
                ),

              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: lostItems,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const  Center(child: Text("Etwas ist schiefgegangen"));
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: Text("Loading"));
                          }
                          return GridView.builder(
                            shrinkWrap: true, // Important to avoid unbounded height error
                            physics: const NeverScrollableScrollPhysics(), // To avoid scrolling conflict with CustomScrollView
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 4 / 4, // Adjust as needed
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document = snapshot.data!.docs[index];
                              LostItems data = LostItems.fromFirestore(document);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(lostItem: data),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        // color: Color(0xFFF56C42),
                                        blurRadius: 4.0,
                                        spreadRadius: 1.05,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      if (data.itemBild.isNotEmpty)
                                        Image.network(
                                          data.itemBild,
                                          height: 100,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        )
                                      else
                                        //const SizedBox.shrink(),
                                      const SizedBox(height: 10),
                                      Text(
                                        data.itemName,
                                        style: const TextStyle(fontFamily: ''),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              data.itemStatus,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'RobotoMono',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              data.itemDateFound.toString(),
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
                            },
                          );
                        },
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
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: DefaultTabController(
                          length: 4,
                          child: UserProfile(),
                        ),
                      ),
                    ),
                  );
                },
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
                },
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
                },
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
                },
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
                },
              ),
            ),
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
