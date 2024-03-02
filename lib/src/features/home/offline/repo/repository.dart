import 'dart:async'; 
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/api.dart';
import '../../../../utils/functions.dart';

class DatabaseAssistance {
  static const int version = 1;
  static const String dbname = 'Record.db';

  static Future<Database> getDB() async {
    const String sql =
        "CREATE TABLE Drecords (id INTEGER PRIMARY KEY, staffcode VARCHAR NOT NULL, ddate VARCHAR NOT NULL, dtime VARCHAR NOT NULL)";
    try {
      return await openDatabase(
        join(await getDatabasesPath(), dbname),
        onCreate: (db, version) async => await db.execute(sql),
        version: version,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertRecord(String staffcode, String ddate, String dtime) async {
    final db = await getDB();
    await db.insert(
      'Drecords',
      {'staffcode': staffcode, 'ddate': ddate, 'dtime': dtime},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRecord(String staffcode, String ddate, String dtime) async {
    final db = await getDB();
    await db.update(
      'Drecords',
      {'staffcode': staffcode, 'ddate': ddate, 'dtime': dtime},
      where: 'staffcode = ?',
      whereArgs: [staffcode],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteRecord(String staffcode) async {
    final db = await getDB();
    await db.delete(
      'Drecords',
      where: 'staffcode = ?',
      whereArgs: [staffcode],
    );
  }

  Future<List<Map<String, dynamic>>?> getAllRecords() async {
    final db = await getDB();
    return await db.query('Drecords');
  }

  Future<void> submitAndDeleteAllRecords() async {
    try {
      // Assuming your API endpoint for submission
      var apiUrl = API.offline;

      final position = await AppFunctions.getLocation();
      final latitude = position!.latitude.toString();
      final longitude = position.longitude.toString();
      final address = await AppFunctions.getAddressFromLocation(
          position.latitude, position.longitude);

      // Retrieve all records
      List<Map<String, dynamic>>? records = await getAllRecords();

      if (records != null && records.isNotEmpty) {
        for (var record in records) {
          var data = {
            'staffcode': record['staffcode'],
            'ddate': record['ddate'],
            'time': record['dtime'],
            'latitude': latitude,
            'longitude': longitude,
            'address': address,
          };

          // Make an HTTP POST request to submit data
          var response = await http.post(Uri.parse(apiUrl), body: data);

          // Check if the submission was successful
          if (response.statusCode == 200) {
            // If submission is successful, delete the local record
            await deleteRecord(record['staffcode']);
          }
        }
      }
    } catch (e) {
      // Handle any exceptions that might occur during the process
      // print("Error: $e");
    }
  }
}
