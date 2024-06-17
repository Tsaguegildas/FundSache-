class Users {
  final int? usrId;
  final String usrName;
  final String usrVorname;
  final String usrLand;
  final String usrEmail;
  final String usrPhone;
  final String usrPassword;
  final String usrGenre;
  final int usrRole=0;
// final DateTime usrTag;

  Users({
    this.usrId,
    required this.usrName,
    required this.usrVorname,
    required this.usrLand,
    required this.usrEmail,
    required this.usrPhone,
    required this.usrPassword,
    required this.usrGenre,
    // required this.usrTag,

  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      usrId: map['usrId'],
      usrName: map['usrName'],
      usrVorname: map['usrVorname'],
      usrLand: map['usrLand'],
      usrEmail: map['usrEmail'],
      usrPhone: map['usrPhone'],
      usrPassword: map['usrPassword'],
      usrGenre: map['usrGenre'],
     // usrStatus: map['usrStatus'],
    );
  }

  Map<String, dynamic> toMap()=>{
    "usrId": usrId,
    "usrName": usrName,
    "usrVorname": usrVorname,
   "usrLand":usrLand,
    "usrEmail":usrEmail,
    "usrPhone": usrPhone,
    "usrPassword": usrPassword,
    "usrGenre":usrGenre,
    //"usrTag": usrTag,
    "usrStatus":usrRole,
  };
}
