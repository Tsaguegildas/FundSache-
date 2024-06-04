class LostItems {
  int? itemId;
  String itemName;
  String? itemDescription;
  String itemLocationFound;
  String itemDateFound;
  int? finderId; // Verweisst dem User, der das Items gefunden oder verloren hat
  String itemStatus;

  LostItems({
    this.itemId,
    required this.itemName,
    this.itemDescription,
    required this.itemLocationFound,
    required this.itemDateFound,
    this.finderId,
    required this.itemStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemLocationFound': itemLocationFound,
      'itemDateFound': itemDateFound,
      'finderId': finderId,
      'itemStatus': itemStatus,
    };
  }


  factory LostItems.fromMap(Map<String, dynamic> map) {
    return LostItems(
      itemId: map['itemId'],
      itemName: map['itemName'],
      itemDescription: map['itemDescription'],
      itemLocationFound: map['itemLocationFound'],
      itemDateFound: map['itemDateFound'],
      finderId: map['finderId'],
      itemStatus: map['itemStatus'],
    );
  }
}
