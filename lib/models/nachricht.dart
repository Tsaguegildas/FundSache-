class Nachricht {
  int? nachrichtId;
  String text;
  bool istVonmir;
  int userId;
  int itemId;
  DateTime dateSend;

  Nachricht({
    this.nachrichtId,
    required this.text,
    required this.istVonmir,
    required this.userId,
    required this.itemId,
    required this.dateSend,
  });

  Map<String, dynamic> toMap() {
    return {
      'nachrichtId': nachrichtId,
      'text': text,
      'istVonmir': istVonmir ? 1 : 0,
      'userId': userId,
      'itemId': itemId,
      'dateSend': dateSend.toIso8601String(), // hier um ein String zurück zu geben
    };
  }


  factory Nachricht.fromMap(Map<String, dynamic> map) {
    return Nachricht(
      nachrichtId: map['nachrichtId'],
      text: map['text'],
      istVonmir: map['istVonmir'] == 1,
      userId: map['userId'],
      itemId: map['itemId'],
      dateSend: DateTime.parse(map['dateSend']), // // hier um ein DateTime zurück zu geben
    );
  }
}
