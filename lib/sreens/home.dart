import 'package:flutter/material.dart';
import 'package:fundvgsache/sreens/authentifacation/login.dart';
import 'package:fundvgsache/sreens/authentifacation/signup.dart';
import 'package:fundvgsache/test/item_store.dart';
import '../test/item.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FundSache',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Signup(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final ItemStore _itemStore = ItemStore();
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await _itemStore.getItems();
    setState(() {
      _items = items;
    });
  }

  void _addItem() async {
    if (_controller.text.isNotEmpty) {
      final item = Item(id: DateTime.now().millisecondsSinceEpoch.toString(), name: _controller.text);
      await _itemStore.addItem(item);
      _controller.clear();
      _loadItems();
    }
  }

  void _deleteItem(String id) async {
    await _itemStore.deleteItem(id);
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sembast Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Item Name',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteItem(item.id as String),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}