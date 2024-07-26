import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/homesreens.dart';
import '../../models/lostItem.dart';
import '../../service/authService.dart';
import '../authentifikation/login.dart';
import '../details_page.dart';
import '../suchBar.dart';
import '../user_appBar.dart';

class Homeadmin extends StatefulWidget {
  Homeadmin({super.key});

  @override
  State<Homeadmin> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<Homeadmin> {
  late Stream<QuerySnapshot> lostItemsStream;
  String filterCategory = 'alle'; // Default filter to show all items

  @override
  void initState() {
    super.initState();
    _updateLostItemsStream();
  }

  void _updateLostItemsStream() {
    if (filterCategory == 'alle') {
      lostItemsStream = FirebaseFirestore.instance
          .collection('LostItem')
          .snapshots();
    } else if (filterCategory == 'verloren') {
      lostItemsStream = FirebaseFirestore.instance
          .collection('LostItem')
          .where('statut', isEqualTo: true)
          .snapshots();
    } else {
      lostItemsStream = FirebaseFirestore.instance
          .collection('LostItem')
          .where('statut', isEqualTo: false)
          .snapshots();
    }
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        onPressed: () {
                          setState(() {
                            filterCategory = 'gefunden';
                            _updateLostItemsStream();
                          });
                        },
                        child: Text("Zu validieren"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            filterCategory = 'verloren';
                            _updateLostItemsStream();
                          });
                        },
                        child: Text("Validiert"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            filterCategory = 'alle';
                            _updateLostItemsStream();
                          });
                        },
                        child: Text("Alle"),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: lostItemsStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text("Etwas ist schiefgegangen"));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text("Loading"));
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 4 / 4,
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
                                  ),
                                const SizedBox(height: 1),
                                Text(
                                  data.itemName,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red, size: 30),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('LostItem')
                                                .doc(document.id)
                                                .delete();
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const SizedBox(width: 20),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(Icons.verified_user_outlined,
                                              color: Colors.green, size: 30),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('LostItem')
                                                .doc(document.id)
                                                .update({'statut': true});
                                            print(data.statut);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Admin",style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Align(
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
                title: Text("Home"),
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: DefaultTabController(
                          length: 4,
                          child: Homescreen(),
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
                title: Text("Benutzer"),
                onTap: () async {},
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
                      builder: (_) =>  MaterialApp(
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
}
