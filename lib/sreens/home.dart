// import 'package:flutter/material.dart';
// import 'package:fundvgsache/models/benutzer.dart';
// import 'package:fundvgsache/models/user.dart';
//
//
// class MyHomePage extends StatefulWidget {
//   final Users user;
//
//   MyHomePage({required this.user});
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page d\'accueil'),
//         actions: <Widget>[
// //------------------------------------------------------------------------------------------------------------------------------
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Action pour le bouton de recherche
//             },
//           ),
// //------------------------------------------------------------------------------------------------------------------------------
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Action pour le bouton de notification
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Welcome, ${widget.user.usrEmail}'),
//             Text('Password: ${widget.user.usrPassword}'), // Ne pas afficher en production
//           ],
//         ),
//       ),
//     );
//   }
// }
