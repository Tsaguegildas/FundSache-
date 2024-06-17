class LostItems {
  int? itemId;
  String itemName;
  String? itemBeschreibung;
  String itemLocationFund;
  String itemDateFound;
  int? finderId; // Verweisst dem User, der das Items gefunden oder verloren hat
  String itemStatus;

  String ? itemBild;


  LostItems({
    this.itemId,
    required this.itemName,
    this.itemBeschreibung,
    required this.itemLocationFund,
    required this.itemDateFound,
    this.finderId,
    required this.itemStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemBeschreibung,
      'itemLocationFound': itemLocationFund,
      'itemDateFound': itemDateFound,
      'finderId': finderId,
      'itemStatus': itemStatus,
    };
  }


  factory LostItems.fromMap(Map<String, dynamic> map) {
    return LostItems(
      itemId: map['itemId'],
      itemName: map['itemName'],
      itemBeschreibung: map['itemDescription'],
      itemLocationFund: map['itemLocationFound'],
      itemDateFound: map['itemDateFound'],
      finderId: map['finderId'],
      itemStatus: map['itemStatus'],
    );
  }
}
