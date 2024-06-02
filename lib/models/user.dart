class Users {
  final int? usrId;
  final String usrName;
  final String usrVorname;
  final String usrLand;
  final String usrEmail;
  final String usrPhone;
  final String usrPassword;
  final String usrGenre;
 // final DateTime usrTag;
  final int ? usrStatus;


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
    this.usrStatus,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    usrId: json["usrId"],
    usrName: json["usrName"],
    usrVorname: json["usrVorname"],
    usrLand: json["usrLand"],
    usrEmail: json["usrEmail"],
    usrPhone: json["usrPhone"],
    usrPassword: json["usrPassword"],
    usrGenre: json["usrGenre"],
    //usrTag: json["usrTag"],
    usrStatus: json["usrStatus"],
  );

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
    "usrStatus":usrStatus,
  };
}
