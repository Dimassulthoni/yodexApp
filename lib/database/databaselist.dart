import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yodex/model/pengeluaran.dart';

class listdatabase {
  static final listdatabase instance = listdatabase._init();

  static Database? _database;
  listdatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('list.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tablepengeluaran(
      ${expensesFields.id}$idType,
      ${expensesFields.nama}$textType,
      ${expensesFields.harga}$integerType,
      ${expensesFields.time}$textType
    )''');
  }

  Future<pengeluaran> create(pengeluaran expenses) async {
    final db = await instance.database;

    // final id = await db.rawInsert('INSERT INTO table_nama ($Columns) VALUES ($values)')
    final id = await db.insert(tablepengeluaran, expenses.toJson());
    return expenses.copy(id: id);
  }

  Future<pengeluaran> readpengeluaran(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablepengeluaran,
      columns: expensesFields.values,
      where: '${expensesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return pengeluaran.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<pengeluaran>> readAllpengeluaran() async {
    final db = await instance.database;

    final orderBy = '${expensesFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tablepengeluaran, orderBy: orderBy);

    return result.map((json) => pengeluaran.fromJson(json)).toList();
  }

  Future<int> update(pengeluaran note) async {
    final db = await instance.database;

    return db.update(
      tablepengeluaran,
      note.toJson(),
      where: '${expensesFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablepengeluaran,
      where: '${expensesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
