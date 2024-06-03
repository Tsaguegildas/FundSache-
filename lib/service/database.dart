import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:path/path.dart';
import '';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._internal();
  static Database? _database;

  AppDatabase._internal();

  factory AppDatabase() {
    return _singleton;
  }

  Future<Database> get database async {
    _database ??= await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    if (kIsWeb) {
      return await databaseFactoryMemoryFs.openDatabase('app_database');
    } else {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, 'app_database.db');
      return await databaseFactoryIo.openDatabase(dbPath);
    }
  }
}