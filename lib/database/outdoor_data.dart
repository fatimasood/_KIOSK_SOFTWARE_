import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OutdoorFormBackend {
  Database? _database;

  // Initialize the database
  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'outdoor_form.db');

    await deleteDatabase(path);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        if (kDebugMode) {
          print("Creating database and table...");
        }
        return db.execute(
          '''
          CREATE TABLE outdoor_form (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT,
            last_name TEXT,
            primary_email TEXT,
            phone_number TEXT,
            unit_number TEXT,
            start_date TEXT,
            license_plate TEXT,
            access_card TEXT,
            secondary_first_name TEXT,
            secondary_last_name TEXT,
            secondary_email TEXT,
            secondary_phone TEXT,
            description TEXT,
            date_time TEXT,
            is_subscribed INTEGER,
            lease_duration TEXT,
            monthly_rent TEXT,
            security_deposit TEXT
          )
          ''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          if (kDebugMode) {
            print("Upgrading database to version 2...");
          }
          await db.execute(
              'ALTER TABLE outdoor_form ADD COLUMN lease_duration TEXT');
          await db
              .execute('ALTER TABLE outdoor_form ADD COLUMN monthly_rent TEXT');
          await db.execute(
              'ALTER TABLE outdoor_form ADD COLUMN security_deposit TEXT');
        }
      },
    );

    if (kDebugMode) {
      print("Database initialized at path: $path");
    }
  }

  // Save or update form data in the database
  Future<void> saveFormData(Map<String, dynamic> formData) async {
    if (_database == null) {
      await initDatabase();
    }

    try {
      // Check if the form already has an 'id' (indicating an update)
      if (formData.containsKey('id')) {
        // Update existing record
        await updateFormData(formData);
      } else {
        // Insert new record
        if (kDebugMode) {
          print("Saving new data to database...");
        }
        final id = await _database!.insert('outdoor_form', formData);
        if (kDebugMode) {
          print("Data saved successfully with ID: $id");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving data to database: $e");
      }
    }
  }

  // Update form data
  Future<void> updateFormData(Map<String, dynamic> formData) async {
    if (_database == null) {
      await initDatabase();
    }

    try {
      final id = formData['id'];
      if (kDebugMode) {
        print("Updating data with ID: $id");
      }

      await _database!.update(
        'outdoor_form',
        formData,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (kDebugMode) {
        print("Data updated successfully for ID: $id");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error updating data: $e");
      }
    }
  }

  // Fetch all form data
  Future<void> fetchAllData() async {
    if (_database == null) {
      await initDatabase();
    }

    try {
      if (kDebugMode) {
        print("Fetching all data from database...");
      }
      final data = await _database!.query('outdoor_form');
      if (kDebugMode) {
        print("Fetched data: $data");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    }
  }
}
