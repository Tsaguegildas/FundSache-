import 'package:flutter/material.dart';
import 'package:fundvgsache/models/user.dart';
import 'package:fundvgsache/service/database_helper.dart';
import 'package:fundvgsache/sreens/authentifacation/signup.dart';
import 'package:fundvgsache/sreens/home.dart';
import '../../models/benutzer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final usrPassword = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;
  final formKey = GlobalKey<FormState>();

  login() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: usrPassword,
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
                          final dbHelper = DatabaseHelper();
                          var result = await dbHelper.loginUsr(email.text, usrPassword.text);
                          if (result) {
                            var userMap = await dbHelper.getUser(email.text, usrPassword.text);
                            if (userMap != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(user: userMap),
                                ),
                              );
                            }
                          } else {
                            print("Der user ist noch nicht in der BD");
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
                                  builder: (context) => const Signup()));
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                  isLoginTrue
                      ? const Text(
                    " UserName oder PassWord stimmt nicht",
                    style: TextStyle(color: Colors.red),
                  )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
