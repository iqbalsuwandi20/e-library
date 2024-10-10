import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/book_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'books.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE books(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            email TEXT,
            pdfPath TEXT,
            description TEXT,
            isFavorite INTEGER DEFAULT 0
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute(
              'ALTER TABLE books ADD COLUMN isFavorite INTEGER DEFAULT 0');
        }
      },
    );
  }

  Future<void> insertBook(BookModel book) async {
    final db = await database;
    await db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BookModel>> getBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');

    return List.generate(maps.length, (i) {
      return BookModel.fromMap(maps[i]);
    });
  }

  Future<void> deleteBook(int id) async {
    final db = await database;
    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update status favorit buku berdasarkan ID
  Future<void> updateFavoriteStatus(int id, bool isFavorite) async {
    final db = await database;
    await db.update(
      'books',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Mendapatkan buku yang difavoritkan
  Future<List<BookModel>> getFavoriteBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'books',
      where: 'isFavorite = ?',
      whereArgs: [1], // Mengambil buku yang difavoritkan
    );

    return List.generate(maps.length, (i) {
      return BookModel.fromMap(maps[i]);
    });
  }
}
