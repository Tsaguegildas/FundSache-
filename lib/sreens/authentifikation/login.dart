import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fundvgsache/models/user.dart';
import 'package:fundvgsache/service/database_helper.dart';
import 'package:fundvgsache/sreens/authentifikation/signup.dart';

import 'package:fundvgsache/sreens/homesreens.dart';
import '../../models/benutzer.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../service/authService.dart';


class LoginScreen extends StatefulWidget {
  // final Function toggleView;

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final email = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;
  final formKey = GlobalKey<FormState>();

  final AuthService _auth= AuthService();


  login() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
  String imageUrl='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "lib/assets/img.png",
                    width: 200,
                  ),
                  const SizedBox(height: 15),
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
                          return " Du muss deine Email Adresse eingeben ";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
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
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " Du muss dein Password eingeben";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // String email="nguefacktsaguegildas@gmail.com";
                          // String password="audreyles";
                          dynamic result = await _auth.signInWithEmailAnPassword(email.text, password.text);
                          if( result== null){
                            print("error signing in");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homescreen()));
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(" Hast du kein Konto ? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text("Sign Up"),
                      ),
                      IconButton(
                        onPressed: () async{
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file= await imagePicker.pickImage(source: ImageSource.camera);
                          print('${file?.path}');
                          if(file==null)return;

                          String uniqueFileName= DateTime.now().millisecondsSinceEpoch.toString();

                          Reference referenceRoot= FirebaseStorage.instance.ref();
                          Reference referenceDirImages=referenceRoot.child('images');

                          Reference referenceImageToUpload=referenceDirImages.child('${uniqueFileName}');
                          try{
                            await referenceImageToUpload.putBlob(File(file!.path));
                            imageUrl= await referenceImageToUpload.getDownloadURL();
                          }catch(error){}

                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                    ],
                  ),
                  isLoginTrue
                      ? const Text(
                    " UserName oder PassWord stimmt nicht",
                    style: TextStyle(color: Colors.red),
                  )
                      : const SizedBox(),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  //   child: IconButton(
                  //     icon: Icon(Icons.add),
                  //     onPressed: () async {
                  //      dynamic result = await _auth.signInWithEmailAnPassword(email, password);
                  //      if( result== null){
                  //        print("error signing in");
                  //      } else {
                  //        print(" signed in");
                  //        print(result.uid);
                  //      }
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
