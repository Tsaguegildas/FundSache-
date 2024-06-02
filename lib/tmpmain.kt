//class tmpmain {
//}
///**
// *
// * import 'package:flutter/material.dart';
// * import 'package:sqflite/sqflite.dart';
// * import 'database_helper.dart';
// * import 'item.dart';
// *
// * import 'package:sqflite_common/sqlite_api.dart';
// *
// * Future main() async {
// *   // sqfliteFfiInit();
// *   //databaseFactory = databaseFactoryFfi;
// *   runApp(MyApp());
// * }
// *
// * class MyApp extends StatelessWidget {
// *   @override
// *   Widget build(BuildContext context) {
// *     return MaterialApp(
// *       title: 'Flutter SQLite Example',
// *       theme: ThemeData(
// *         primarySwatch: Colors.blue,
// *       ),
// *       home: MyHomePage(),
// *     );
// *   }
// * }
// *
// * class MyHomePage extends StatefulWidget {
// *   @override
// *   _MyHomePageState createState() => _MyHomePageState();
// * }
// *
// * class _MyHomePageState extends State<MyHomePage> {
// *   final DatabaseHelper _dbHelper = DatabaseHelper();
// *   final TextEditingController _controller = TextEditingController();
// *   List<Item> _items = [];
// *
// *   @override
// *   void initState() {
// *     super.initState();
// *     _refreshItems();
// *   }
// *
// *   void _refreshItems() async {
// *     final data = await _dbHelper.getItems();
// *     setState(() {
// *       _items = data.map((item) => Item(id: item['id'], name: " id= ${item['id']} name: ${item['name']}")).toList();
// *     });
// *   }
// *
// *   void _addItem() async {
// *     if (_controller.text.isNotEmpty) {
// *       await _dbHelper.insertItem({'name': _controller.text});
// *       _controller.clear();
// *       _refreshItems();
// *     }
// *   }
// *
// *   @override
// *   Widget build(BuildContext context) {
// *     return Scaffold(
// *       appBar: AppBar(
// *         title: Text('Flutter SQLite Example'),
// *       ),
// *       body: Column(
// *         children: [
// *           Padding(
// *             padding: const EdgeInsets.all(16.0),
// *             child: Row(
// *               children: [
// *                 Expanded(
// *                   child: TextField(
// *                     controller: _controller,
// *                     decoration: InputDecoration(
// *                       labelText: 'Item Name',
// *                     ),
// *                   ),
// *                 ),
// *                 IconButton(
// *                   icon: Icon(Icons.add),
// *                   onPressed: _addItem,
// *                 ),
// *               ],
// *             ),
// *           ),
// *           Expanded(
// *             child: ListView.builder(
// *               itemCount: _items.length,
// *               itemBuilder: (context, index) {
// *                 return ListTile(
// *                   title: Text(_items[index].name),
// *                 );
// *               },
// *             ),
// *           ),
// *         ],
// *       ),
// *     );
// *   }
// * }
// *
// */