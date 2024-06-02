import 'package:sembast/sembast.dart';
import '../service/database.dart';
import 'item.dart';

class ItemStore {
  static const String storeName = 'items';

  final _itemStore = intMapStoreFactory.store(storeName);

  Future<Database> get _db async => await AppDatabase().database;

  Future<void> addItem(Item item) async {
    await _itemStore.add(await _db, item.toJson());
  }

  Future<List<Item>> getItems() async {
    final recordSnapshots = await _itemStore.find(await _db);

    return recordSnapshots.map((snapshot) {
      final item = Item.fromJson(snapshot.value);
      item.id = snapshot.key.toString();
      item.name = "${item.id} : ${item.name}";
      return item;
    }).toList();
  }

  Future<void> deleteItem(String id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _itemStore.delete(await _db, finder: finder);
  }
}