import 'package:flutter/material.dart';
import 'package:fundvgsache/sreens/authentifacation/signup.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //----- hier brauche ich zwei Kontroller, um den Username und das Password zu verwalten ---////
  final usrName = TextEditingController();
  final usrPassword = TextEditingController();

  ///-- Um das Password zu zeigen oder verbergen ----////
  bool isVisible = false;
  //DatabaseHelper db = DatabaseHelper.instance;

  login() async {
    WidgetsFlutterBinding.ensureInitialized();
    //final db = DatabaseHelper.instance;
    // var response= await db.loginUsr(Users(usrName: usrName.text, usrPassword: usrPassword.text));
    //  if(response == 1){
    //    print(" Der User   ${response}");
    //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
    //  } else{
    //    //  setState(() {
    //    //    isLoginTrue=true;
    //    //  });
    //    // Navigator.push(
    //    //     context,
    //    //     MaterialPageRoute(
    //    //         builder: (context) => const Signup()));
    //    print("Le non  2 est  ${response}");
    //
    //  }
  }

  bool isLoginTrue = false;

  /// eine globale key für die  Felder in unserem Projekt---/////
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            //--- Hier ist alles in einem Formular geordnet --////
            child: Form(
              key:
              formKey, // ----Jetzt kann ich auf alle Variablen greifen----- //
              child: Column(
                children: [
                  Image.asset(
                    "lib/assets/img.png",
                    width: 200,
                  ),
                  const SizedBox(height: 15),

                  ///////////////////// Hier ist der User Feld.///////////////////

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
                          return " Du muss ein Username eingeben ";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),

                  ////////////////  Hier der PasswortsFeld///////////////

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
                            //////// Hier schaffen ich den Klic, um das Password zu zeigen oder verbergen ////////
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

                  //------ Jetzt der Login Button----////

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
                          ///--- ------------------- ---//
                          // final v2 = Users(usrName: "Gildas", usrPassword: "gildas0740");

                         // DatabaseHelper dt= DatabaseHelper.instance;
                          //int r = await dt.createUser();
                         // print(" ${r} bishier ist alles Ok");

                          // print(r.toString());
                          // login();
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  ///// ----- Sign up Button -----///

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
                  ////----- Hier zeige ich den Text, wenn usrName und usr usrPasswort nicht stimmt ----////
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
