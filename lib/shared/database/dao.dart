import 'package:nwl/shared/models/boleto_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class BoletoDao{


  Future<void> insertFavorite(BoletoModel boleto) async {
    final Database db = await getDatabase();

    await db.insert(
        'boletos',
        boleto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<BoletoModel>> getBoletos() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('boletos');

    return List.generate(
      maps.length,
          (index) {
        return BoletoModel(
          id: maps[index]['id'],
          name: maps[index]['name'],
          dueDate: maps[index]['due_date'],
          value: maps[index]['value'],
          barcode: maps[index]['barcode'],
        );
      },
    );
  }


  Future<void> deleteBoleto(String id) async {
    final Database db = await getDatabase();

    await db.delete(
      'boletos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}