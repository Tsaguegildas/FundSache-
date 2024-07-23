import 'package:cloud_firestore/cloud_firestore.dart';

class LostItems {
  //int? itemId;
  String itemName;
  String itemMarque;
  String itemBeschreibung;
  String itemLocationFund;
  String itemDateFound;
  String finderId; // Verweisst dem User, der das Items gefunden oder verloren hat
  String itemStatus;
  String itemBild;
  DateTime creatAm = DateTime.now();
  bool statut = false;

  LostItems(
      { //this.itemId,
      required this.itemName,
      required this.itemMarque,
      required this.itemBeschreibung,
      required this.itemLocationFund,
      required this.itemDateFound,
      required this.finderId,
      required this.itemStatus,
      required this.itemBild,
      required this.creatAm});

  Map<String, dynamic> toMap() {
    return {
      //'itemId': itemId,
      'itemName': itemName,
      'itemMarque': itemMarque,
      'itemBeschreibung': itemBeschreibung,
      'itemLocationFound': itemLocationFund,
      'itemDateFound': itemDateFound,
      'finderId': finderId,
      'itemStatus': itemStatus,
      'creatAm': creatAm,
      'statut': statut,
      'itemBild' : itemBild,
    };
  }
  factory LostItems.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return LostItems(
      itemName: data['itemName'] ?? 'Kein Name',
      itemStatus: data['itemStatus'] ?? 'Kein Status',
      itemDateFound: data['itemDateFound'] ?? 'Kein Datum',
      itemBild: data['itemBild'] ?? '',
      creatAm: DateTime.now(),
      finderId: "2",
      itemBeschreibung: data['itemBeschreibung'] ?? 'Keine Beschreibung',
      itemLocationFund: data['itemLocationFound'] ?? 'Keinen Fundort wurden eingegeben ',
      itemMarque: data['itemMarque'] ?? 'Keine Marque',
    );
  }

  factory LostItems.fromMap(Map<String, dynamic> map) {
    return LostItems(
      // itemId: map['itemId'],
      itemName: map['itemName'],
      itemMarque: map['itemMarque'],
      itemBeschreibung: map['itemDescription'],
      itemLocationFund: map['itemLocationFound'],
      itemDateFound: map['itemDateFound'],
      finderId: map['finderId'],
      itemStatus: map['itemStatus'],
      itemBild: map ['itemBild'],
      creatAm: map['creatAm'],
    );
  }
}
