import 'package:sqflite/sqflite.dart';

const String historyItem = 'history';
const String historyId = 'id';
const String historyText = 'text';
const String historyNumber = 'number';
const String historyDateTime = 'dateTime';

class Number {
  int? id;
  String number;
  String dateTime;

  Number({
    this.id,
    required this.number,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'number': number, 'dateTime': dateTime};
  }

  @override
  String toString() {
    return 'Number(id: $id, number: $number, dateTime: $dateTime)';
  }

  static Number fromJson(Map<String, Object?> json) => Number(
    id: json[historyId] as int?,
    number: json[historyNumber] as String,
    dateTime: json[historyDateTime] as String
  );
}

