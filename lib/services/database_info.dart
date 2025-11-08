import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Utility untuk mendapatkan informasi database
class DatabaseInfo {
  /// Print lokasi database
  static Future<void> printDatabasePath() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'school_management.db');

    print('=================================');
    print('📂 LOKASI DATABASE SQLite');
    print('=================================');
    print('Path: $path');
    print('Database Name: school_management.db');
    print('=================================');
  }

  /// Check apakah database exists
  static Future<bool> isDatabaseExists() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'school_management.db');

    return await databaseExists(path);
  }

  /// Delete database (untuk testing)
  static Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'school_management.db');

    await databaseFactory.deleteDatabase(path);
    print('✅ Database berhasil dihapus: $path');
  }
}

