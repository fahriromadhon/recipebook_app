import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();

  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, "recipebook.db");
    return await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 2,
        singleInstance: true,
        onCreate: (db, version) async {
          await _createTable(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute(
              "ALTER TABLE my_recipes ADD COLUMN local_video_path TEXT DEFAULT ''",
            );
          }
        },
      ),
    );
  }

  Future<void> _createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS my_recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        api_id TEXT,
        name TEXT,
        category TEXT,
        area TEXT,
        image_url TEXT,
        local_image_path TEXT,
        local_video_path TEXT,
        instructions TEXT,
        ingredients TEXT,
        note TEXT,
        created_at TEXT
      )
    ''');
  }
}
