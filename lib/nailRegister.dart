import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class NailDatabase {
  late Database database;

Future<void> createDatabase() async {
    database = await openDatabase(

    join(await getDatabasesPath(), 'naildatabase.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE nails(id INTEGER PRIMARY KEY, data TEXT, tMiEs REAL, tAnEs REAL, tMeEs REAL, tInEs REAL, tPoEs REAL, tPoDi REAL, tInDi REAL, tMeDi REAL, tAnDi REAL, tMiDi REAL)',
      );
    },
    version: 1,
  );
}

  Future<void> registerNail(Nail nail) async {
    final db = database;

    await db.insert(
      'nails',
      nail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Nail>> nails() async {
  final db = database;
  final List<Map<String, Object?>> nailMaps = await db.query('nails');

  return nailMaps.map((map) => Nail.fromMap(map)).toList();
}

  Future<void> updateNail(Nail nail) async {
    final db = database;

    await db.update(
      'nails',
      nail.toMap(),
      where: 'id = ?',
      whereArgs: [nail.id],
    );
  }

  Future<void> deleteNail(int id) async {
    final db = database;

    await db.delete(
      'nails',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  int autoIncrement() {
    final db = database;
    String a = db.rawQuery('count(*) from nails').toString();
    int b = int.parse(a);
    b++;
    return b;

  }
}

class Nail {
  final int id;
  final DateTime data;
  final double tMiEs;
  final double tAnEs;
  final double tMeEs;
  final double tInEs;
  final double tPoEs;
  final double tPoDi;
  final double tInDi;
  final double tMeDi;
  final double tAnDi;
  final double tMiDi;

  Nail({required this.id, required this.data, required this.tMiEs, required this.tAnEs, required this.tMeEs, required this.tInEs, required this.tPoEs, required this.tPoDi, required this.tInDi, required this.tMeDi, required this.tAnDi, required this.tMiDi});

    Map<String, Object?> toMap() {
    return {
      'id': id,
      'date': data.toIso8601String(),
      'tMiEs': tMiEs,
      'tAnEs': tAnEs,
      'tMeEs': tMeEs,
      'tInEs': tInEs,
      'tPoEs': tPoEs,
      'tPoDi': tPoDi,
      'tInDi': tInDi,
      'tMeDi': tMeDi,
      'tAnDi': tAnDi,
      'tMiDi': tMiDi,
    };
  }

  static Nail fromMap(Map<String, dynamic> map) {
    return Nail(
      id: map['id'],
      data: DateTime.parse(map['data']),
      tMiEs: map['tMiEs'],
      tAnEs: map['tAnEs'],
      tMeEs: map['tMeEs'],
      tInEs: map['tInEs'],
      tPoEs: map['tPoEs'],
      tPoDi: map['tPoDi'],
      tInDi: map['tInDi'],
      tMeDi: map['tMeDi'],
      tAnDi: map['tAnDi'],
      tMiDi: map['tMiDi'],
    );
  }

  @override
  String toString() {
    return 'Nail{id: $id, Mindinho Esquerdo: $tMiEs, Anelar Esquerdo: $tAnEs}';
  }
}