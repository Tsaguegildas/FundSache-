import 'package:fundvgsache/models/benutzer.dart';
import 'package:fundvgsache/models/user.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'example.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT)',
    );
    await db.execute('CREATE TABLE Users ('
        'usrId INTEGER PRIMARY KEY AUTOINCREMENT,'
        'usrName TEXT NOT NULL,'
        'usrVorname TEXT NOT NULL,'
        'usrLand TEXT NOT NULL,'
        'usrEmail TEXT NOT NULL,'
        'usrPhone TEXT NOT NULL,'
        'usrPassword TEXT NOT NULL,'
        'usrGenre TEXT NOT NULL,'
        'usrStatus INTEGER NOT NULL DEFAULT 0'
        ')');
    await db.execute('CREATE TABLE LostItems ('
        'itemId INTEGER PRIMARY KEY AUTOINCREMENT,'
        'itemName TEXT NOT NULL,'
        'itemDescription TEXT,'
        'itemLocationFound TEXT NOT NULL,'
        'itemDateFound TEXT NOT NULL,'
        'finderId INTEGER,'
        'itemStatus TEXT NOT NULL,'
        'FOREIGN KEY (finderId) REFERENCES Users (usrId) ON DELETE SET NULL'
        ')');
  }
  //---------- Function um User in UserTable hinzuzufügen ---------------------------------------------------//


  Future<int> insertUser(Users user) async {
    Database db = await database;
    return await db.insert('Users', user.toMap());
  }

//----------------------------------
  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('Users');
  }

  //-------------------------------
  Future<bool> loginUsr(String email, String passWord) async {
    Database db = await database;
    var result = await db.query(
      'Users',
      where: 'usrEmail = ? AND usrPassword = ?',
      whereArgs: [email, passWord],
    );
    return result.isNotEmpty;
  }

  //----------------------------------------------
  Future<Users> getUser(String email, String passWord) async {
    Database db = await database;
    var result = await db.query(
      'Users',
      where: 'usrEmail = ? AND usrPassword = ?',
      whereArgs: [email, passWord],
    );
      return Users.fromMap(result.first);
  }

  // --------------------------------------Ende User -----------------------------------------------------------------//

  Future<int> insertItem(Map<String, dynamic> item) async {
    Database db = await database;
    return await db.insert('items', item);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    Database db = await database;
    return await db.query('items');
  }
}
