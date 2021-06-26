import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String path = join(await getDatabasesPath(), 'boletos.db');
  return openDatabase(path,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE boletos(id TEXT PRIMARY KEY, name TEXT, due_date TEXT, value DOUBLE, barcode TEXT)',
        );
      }, version: 1);
}