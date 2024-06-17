import 'package:flutter/cupertino.dart';

class Messagepage extends StatefulWidget {
  const Messagepage({super.key});

  @override
  State<Messagepage> createState() => _MessagepageState();
}

class _MessagepageState extends State<Messagepage> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        child: Text("Guten Mogen"),
      ),
    );
  }
}
