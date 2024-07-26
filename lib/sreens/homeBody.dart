import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/admin/homeAdmin.dart';
import 'package:fundvgsache/sreens/itemFormular.dart';
import 'package:fundvgsache/sreens/suchBar.dart';
import 'package:fundvgsache/sreens/userProfile.dart';
import 'package:fundvgsache/sreens/user_appBar.dart';
import 'package:image_picker/image_picker.dart';
import 'authentifikation/login.dart';
import 'details_page.dart';
import '../models/lostItem.dart';

class HomeBody extends StatefulWidget {
  final int selectedIndex;
  final String selectedLabel;

  HomeBody(
      {super.key, required this.selectedIndex, required this.selectedLabel});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String userRole = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? user;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    lostItems = _getLostItems();
    user = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(user!.uid).get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  File? image;
  String itemImage = "Fügen Sie hier ein Bild";
  String? profileImageUrl;
  late Stream<QuerySnapshot> lostItems;

  @override
  void filterStream(String kategorie) {
    setState(() {
      lostItems = FirebaseFirestore.instance
          .collection('LostItem')
          .where('itemKategorie', isEqualTo: kategorie)
          .where('statut', isEqualTo: true)
          .snapshots();
    });
  }

  Stream<QuerySnapshot> _getLostItems() {
    return FirebaseFirestore.instance
        .collection('LostItem')
        .where('statut', isEqualTo: true)
        .snapshots();
  }

  Future<void> _pickImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      setState(() {
        image = File(file.path);
      });

      try {
        String uniqueFileName =
            DateTime.now().millisecondsSinceEpoch.toString();
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('images');
        Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);

        await referenceImageToUpload.putFile(File(file.path));
        String downloadURL = await referenceImageToUpload.getDownloadURL();
        setState(() {
          itemImage = downloadURL;
          profileImageUrl = downloadURL;
        });
      } catch (e) {
        print("$e");
      }
    }
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Aus Galerie wählen'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Mit Kamera aufnehmen'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String userName = userData?['usrName'] ?? 'Nom Utilisateur';

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
              _buildCategoryFilter(context),
              _buildLostItemsGrid(),
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
        tooltip: 'Item speichern',
      ),
      drawer: _buildDrawer(context, userName),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Text(
            "Kategorie",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          Flexible(
            child: TextButton(
              onPressed: () => filterStream("verloren"),
              child: Text("Verloren"),
            ),
          ),
          Flexible(
            child: TextButton(
              onPressed: () => filterStream("gefunden"),
              child: Text("Gefunden"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLostItemsGrid() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: lostItems,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Etwas ist schiefgegangen"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }
          return GridView.builder(
            shrinkWrap: true,
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
              return _buildLostItemCard(data);
            },
          );
        },
      ),
    );
  }

  Widget _buildLostItemCard(LostItems data) {
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
            const SizedBox(height: 5),
            Text(
              data.itemName,
              style: const TextStyle(fontFamily: ''),
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      data.itemKategorie,
                      style: TextStyle(
                        fontSize: 10,
                        color: data.itemKategorie == "verloren"
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      data.itemDateFound.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
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

  Drawer _buildDrawer(BuildContext context, String userName) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(context),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepPurple.withOpacity(.3),
            ),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Mein Profil"),
              onTap: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: DefaultTabController(
                        length: 4,
                        child:
                            UserProfile(), // HomeScreen par défaut si page est null
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
              leading: Icon(Icons.list),
              title: Text("Meine Anzeigen"),
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
              leading: Icon(Icons.message),
              title: Text("Nachrichten"),
              onTap: () async {},
            ),
          ),
          if (userData?['usrRole'] == "admin")
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.withOpacity(.3),
              ),
              child: ListTile(
                leading: Icon(Icons.admin_panel_settings),
                title: Text("Admin"),
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: DefaultTabController(
                          length: 4,
                          child: Homeadmin(),
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
              leading: Icon(Icons.logout),
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
                        child:
                            LoginScreen(), // HomeScreen par défaut si page est null
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DrawerHeader _buildDrawerHeader(BuildContext context) {
    final String profileImageUrl = userData?['bildProfile'] ?? '';
    final String userName = userData?['usrName'] ?? 'Nom Utilisateur';
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: profileImageUrl.isNotEmpty
                ? NetworkImage(profileImageUrl)
                : const AssetImage('assets/default_profile.png')
                    as ImageProvider,
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt_sharp),
            color: Colors.white,
            onPressed: () => _showImageSourceActionSheet(context),
          ),
          Expanded(
            child: Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
