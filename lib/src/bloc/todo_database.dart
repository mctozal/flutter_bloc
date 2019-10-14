import 'dart:async';
import 'package:flutter_bloc/src/DBHelper/dbHelper.dart';
import 'package:flutter_bloc/src/model/noteModel.dart';

class TodoDao {
  final db = DBProvider.db;

  newClient(Notes newClient) async {
    final dbProvider = await db.database;
    //get the biggest id in the table
    var table = await dbProvider.rawQuery("SELECT MAX(id)+1 as id FROM Notes");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await dbProvider.rawInsert(
        "INSERT Into Notes (id,noteText,noteDate,blocked)"
        " VALUES (?,?,?,?)",
        [id, newClient.noteText, newClient.noteDate, newClient.blocked]);
    return raw;
  }

  blockOrUnblock(Notes client) async {
    final dbProvider = await db.database;
    Notes blocked = Notes(
        id: client.id,
        noteText: client.noteText,
        noteDate: client.noteDate,
        blocked: !client.blocked);
    var res = await dbProvider.update("Notes", blocked.toJson(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(Notes newClient) async {
    final dbProvider = await db.database;
    return dbProvider.update("Notes", newClient.toJson(),
        where: "id = ?", whereArgs: [newClient.id]);
  }

  getClient(int id) async {
    final dbProvider = await db.database;
    var res = await dbProvider.query("Notes", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Notes.fromJson(res.first) : null;
  }

  Future<List<Notes>> searchClient(String search) async {
    final dbProvider = await db.database;
     var res = await dbProvider.query("Notes");
    List<Notes> list =
        res.isNotEmpty ? res.map((c) => Notes.fromJson(c)).toList() : [];
    return list.where((Notes notes)=>notes.noteText.toLowerCase()
    .contains(search.toLowerCase())).toList();
  }

  Future<List<Notes>> getBlockedClients() async {
    final dbProvider = await db.database;
    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res =
        await dbProvider.query("Notes", where: "blocked = ? ", whereArgs: [1]);

    List<Notes> list =
        res.isNotEmpty ? res.map((c) => Notes.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Notes>> getAllClients() async {
    final dbProvider = await db.database;
    var res = await dbProvider.query("Notes");
    List<Notes> list =
        res.isNotEmpty ? res.map((c) => Notes.fromJson(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final dbProvider = await db.database;
    return dbProvider.delete("Notes", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final dbProvider = await db.database;
    dbProvider.rawDelete("Delete * from Notes");
  }
}
