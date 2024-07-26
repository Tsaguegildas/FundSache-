import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fundvgsache/sreens/editUserProfile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? user;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user!.uid).get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: Colors.deepPurple,
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
        Column(
        children: [
        CircleAvatar(
        radius: 50,
          backgroundImage: userData!['itemBild'] != null
              ? NetworkImage(userData!['itemBild'])
              : const AssetImage('assets/default_profile.png') as ImageProvider,
          child: IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditUserProfile()),
              );
            },
            icon: Icon(Icons.edit),
          ),
        ),

        const SizedBox(height: 10),
        Text(
          "${userData!['usrName'] ?? ''} ${userData!['usrVorname'] ?? ''}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          userData!['usrEmail'] ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        ],
      ),
            const SizedBox(height: 20),
      Expanded(
        child: ListView(
          children: [
            _buildProfileItem('Name', userData!['usrName'] ?? ''),
            _buildProfileItem('Vorname', userData!['usrVorname'] ?? ''),
            _buildProfileItem('Geschlecht', userData!['usrGenre'] ?? ''),
            _buildProfileItem('Telefonnummer', userData!['usrPhone'] ?? ''),
            const Divider(),
           Container(
             child:  Row(
               children: [Text("Mein Koton löschen"), ],
             ),
           )
          ],
        ),
      ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

}
