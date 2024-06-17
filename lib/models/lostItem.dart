class LostItems {
  int? itemId;
  String itemName;
  String? itemMarque;
  String? itemBeschreibung;
  String itemLocationFund;
  String itemDateFund;
  int? finderId; // Verweisst dem User, der das Items gefunden oder verloren hat
  String itemStatus;
  String? itemBild;


  LostItems({
    this.itemId,
    required this.itemName,
    this.itemMarque,
    this.itemBeschreibung,
    required this.itemLocationFund,
    required this.itemDateFund,
    this.finderId,
    required this.itemStatus,
    required this.itemBild,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemMarque': itemMarque,
      'itemDescription': itemBeschreibung,
      'itemLocationFound': itemLocationFund,
      'itemDateFound': itemDateFund,
      'finderId': finderId,
      'itemStatus': itemStatus,
    };
  }


  factory LostItems.fromMap(Map<String, dynamic> map) {
    return LostItems(
      itemId: map['itemId'],
      itemName: map['itemName'],
      itemMarque: map['itemMarque'],
      itemBeschreibung: map['itemDescription'],
      itemLocationFund: map['itemLocationFound'],
      itemDateFund: map['itemDateFound'],
      finderId: map['finderId'],
      itemStatus: map['itemStatus'], itemBild: '',
    );
  }
}
