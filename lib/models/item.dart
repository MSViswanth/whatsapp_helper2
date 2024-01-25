import 'package:sqflite/sqflite.dart';

const String historyItem = 'history';
const String historyId = '_id';
const String historyText = 'text';
const String historyNumber = 'number';
const String historyDateTime = 'dateTime';

class Item {
  int id;
  String text;
  String number;
  String dateTime;

  Item({
    required this.id,
    required this.text,
    required this.number,
    required this.dateTime,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'number': number,
      'dateTime': dateTime,
    };
  }

  @override
  String toString() {
    return 'Item(id: $id, text: $text, number: $number, dateTime: $dateTime)';
  }
}

class DatabaseProvider {
  late Database db;
  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'create table $historyItem ($historyId integer primary key autoincrement, $historyText text not null, $historyNumber text not null, $historyDateTime text not null)');
      },
    );
  }

  Future<void> insertItem(Item item) async {
    item.id = await db.insert(
      'history',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Item>> history() async {
    final List<Map<String, dynamic>> maps = await db.query('history');

    return List.generate(
      maps.length,
      (index) {
        return Item(
          id: maps[index]['id'] as int,
          text: maps[index]['text'] as String,
          number: maps[index]['number'] as String,
          dateTime: maps[index]['dateTime'] as String,
        );
      },
    );
  }

  Future<void> deleteItem(int id) async {
    // Get a reference to the database.

    // Remove the Dog from the database.
    await db.delete(
      'history',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
