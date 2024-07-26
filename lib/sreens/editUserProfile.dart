import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fundvgsache/sreens/userProfile.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? user;
  Map<String, dynamic>? userData;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController vornameController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController landController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _phoneNumber;
  String? _landCode;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userDoc =
      await _firestore.collection('Users').doc(user!.uid).get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null) {
          nameController.text = userData!['usrName'] ?? '';
          vornameController.text = userData!['usrVorname'] ?? '';
          genreController.text = userData!['usrGenre'] ?? '';
          phoneController.text = userData!['usrPhone'] ?? '';
          landController.text = userData!['usrLand'] ?? '';
          statusController.text = userData!['itemStatus'] ?? '';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User Profile"),
        backgroundColor: Colors.deepPurple,
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Form(
        key: formKey,
        child: Padding(
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
          ),
          const SizedBox(height: 10),
          Text(
            "${nameController.text} ${vornameController.text}",
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
                Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText:'Name',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Dein Name  muss nicht leer sein ';
                      }
                      return null;
                    },
                  ),
                ),
              ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: TextFormField(
                controller: vornameController,
                decoration: InputDecoration(
                  labelText:'Vorname',
                ),
                  validator: (value) {
                    if (value == null) {
                      return 'Bitte sein Vorname muss nicht leer sein ';
                    }
                    return null;
                  },
              ),
            ),
          ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: TextFormField(
                  controller: genreController,
                  decoration: InputDecoration(
                    labelText:'Geschlecht',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Geschlecht muss nicht leer sein ';
                    }
                    return null;
                  },
                ),
              ),
            ),

                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: IntlPhoneField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone Nummer",
                        ),

                        initialValue: phoneController.text,
                        onChanged: (phone) {
                          _phoneNumber = phone.completeNumber;
                          _landCode = phone.countryCode;

                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Bitte geben Sie eine gültige Telefonnummer ein';
                          }
                          return null;
                        },
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()async {
                  if (formKey.currentState!.validate()) {
                    if (user != null) {
                      await _firestore.collection('Users').doc(user!.uid).update({
                        'usrName': nameController.text,
                        'usrVorname': vornameController.text,
                        'usrGenre': genreController.text,
                        'usrPhone': _phoneNumber.toString(),
                        'usrLand': _landCode.toString(),
                        'itemStatus': statusController.text,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfile()));
                    }
                  }
                },
                child: const Text('Speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
