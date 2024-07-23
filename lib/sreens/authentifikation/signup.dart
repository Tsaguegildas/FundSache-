import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final usrName = TextEditingController();
  final usrVorname = TextEditingController();
  final email = TextEditingController();
  final usrPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  String? geschlecht;
  bool isVisible1 = false;
  bool isVisible2 = false;
  String? _phoneNumber;
  String? _landCode;
  final formKey = GlobalKey<FormState>();

  // Méthode de validation pour le sexe
  String? _validateGender() {
    if (geschlecht == null) {
      return "Bitte wählen Sie ein Geschlecht";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ListTile(
                    title: Center(
                      child: Text(
                        "Anmeldung",
                        style: TextStyle(fontSize: 45),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: usrName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Du musst deinen Namen eingeben";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Ihr Name",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: usrVorname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Du musst deinen Vornamen eingeben";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Vorname",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Du musst deine Email Adresse eingeben";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.mail),
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple.withOpacity(.3)),
                    child: IntlPhoneField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone Numer",
                      ),
                      initialCountryCode: 'Togo',
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
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: usrPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Du musst dein Passwort eingeben";
                        }
                        return null;
                      },
                      obscureText: !isVisible1,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible1 = !isVisible1;
                            });
                          },
                          icon: Icon(isVisible1
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Du musst dein Passwort bestätigen";
                        } else if (usrPassword.text != confirmPassword.text) {
                          return "Passwörter stimmen nicht überein";
                        }
                        return null;
                      },
                      obscureText: !isVisible2,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Wiederhole dein Passwort bitte",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible2 = !isVisible2;
                            });
                          },
                          icon: Icon(isVisible2
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ListTile(
                          title: const Text('Herr'),
                          leading: Radio<String>(
                            value: 'Herr',
                            groupValue: geschlecht,
                            onChanged: (String? value) {
                              setState(() {
                                geschlecht = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ListTile(
                          title: const Text('Frau'),
                          leading: Radio<String>(
                            value: 'Frau',
                            groupValue: geschlecht,
                            onChanged: (String? value) {
                              setState(() {
                                geschlecht = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_validateGender() != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _validateGender()!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            _validateGender() == null) {
                          try {
                            UserCredential userCredential =
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email.text,
                              password: usrPassword.text,
                            );

                            String uid = userCredential.user!.uid;
                            print("Hier ist der Id des User: $uid");

                            // Ajout de l'utilisateur dans Firestore
                            final CollectionReference collref =
                            FirebaseFirestore.instance.collection('Users');

                            var user = {
                              'usrId':uid,
                              'usrName': usrName.text,
                              'usrVorname': usrVorname.text,
                              'usrLand': _landCode.toString(),
                              'usrEmail': email.text,
                              'usrPhone': _phoneNumber.toString(),
                              'usrGenre': geschlecht.toString(),
                              'usrPassword':usrPassword.text,
                              'usrRole':0,
                            };

                            await collref.doc(uid).set(user);
                            print("Hinzufügung des Users geklappt");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Neues Konto erfolgreich hergestellt ')),
                            );
                          } catch (e) {
                            print("Fehler bei der Erstellung des Kontos: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Fehler bei der Erstellung des Kontos: $e')),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "SignIn",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hast du schon ein Konto?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
