import 'package:flutter/material.dart';
import 'package:fundvgsache/models/nachricht.dart';

import 'package:fundvgsache/service/database_helper.dart';

class Messagepage extends StatefulWidget {
  @override
  _MessagepageState createState() => _MessagepageState();
}

class _MessagepageState extends State<Messagepage> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Nachricht> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    List<Nachricht> messages = await _dbHelper.getAllNachrichten();
    setState(() {
      _messages = messages;
    });
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      Nachricht message = Nachricht(
        text: _controller.text,
        istVonmir: true,
        userId: 1,
        itemId: 1,
        dateSend: DateTime.now(),
      );

      try {
        await _dbHelper.insertNachricht(message);
        _controller.clear();
        _loadMessages();
      } catch (e) {
        print("Erreur lors de l'insertion du message : $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Nachricht message) {
    final alignment = message.istVonmir ? Alignment.centerRight : Alignment.centerLeft;
    final color = message.istVonmir ? Colors.blue[100] : Colors.grey[300];
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message.text),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Tippe deine Nachricht hier',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _sendMessage,
            child: Icon(Icons.send),
            mini: true,
          ),
        ],
      ),
    );
  }
}
