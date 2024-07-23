import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: userData!['itemBild'] != null
              ? NetworkImage(userData!['itemBild'])
              : const AssetImage('assets/default_profile.png') as ImageProvider,
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
    );
  }

  Widget _buildProfileInfo() {
    return Expanded(
      child: ListView(
        children: [
          _buildProfileItem('Name', userData!['usrName'] ?? ''),
          _buildProfileItem('Vorname', userData!['usrVorname'] ?? ''),
          _buildProfileItem('Geschlecht', userData!['usrGenre'] ?? ''),
          _buildProfileItem('Telefonnummer', userData!['usrPhone'] ?? ''),
          _buildProfileItem('Land', userData!['usrLand'] ?? ''),
          const Divider(),

          _buildItemDetails('Status', userData!['itemStatus'] ?? '', Icons.check),
        ],
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

  Widget _buildItemDetails(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
