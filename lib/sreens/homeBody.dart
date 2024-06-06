import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fundvgsache/konztante.dart';
import 'package:fundvgsache/sreens/authentifacation/login.dart';
import 'package:fundvgsache/sreens/suchBar.dart';
import 'package:fundvgsache/sreens/user_appBar.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              UserAppBar(),
              SizedBox(height: 20,),
              Suchbar(),
              SizedBox(height: 10,)

            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipOval(
                      child: Image.asset(
                        'lib/assets/moi1.png',
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                 const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(8),
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple.withOpacity(.3)),
              child: ListTile(
                title: Text('Mein Profil'),
                onTap: () {
                  // Action für den Item 1
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
              child: ListTile(
                title: Text('Meine Anzeigen'),
                onTap: () {
                  // Action für den Item 1
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
              child: ListTile(
                title: Text('Nachrichten'),
                onTap: () {
                  // Action für den Item 1
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
              child: ListTile(
                title: Text('Hilfe'),
                onTap: () {
                  // Action für den Item 1
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
              child: ListTile(
                title: Text('Abmelden'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                  // Action für den Item 1
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
