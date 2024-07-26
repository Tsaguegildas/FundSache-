import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/meinUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --------- Um die Benutzererfahrung zu verfolgen--------
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // einloggen mit einer Email und einem Password
  Future signInWithEmailAnPassword(String email, String password) async{
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }

  }

  // ----------------------------------------registern mit email und Password
  Future registerWithEmailAnPassword(String email, String password) async{
    try{
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return user;
    }catch (e){
      print(e.toString());
      return null;
    }

  }

//----------------------------------- Funktion  um sich abzumelden
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }


  /////----------------------------------- -------------------------



  // Future<MyUser?> signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

}
