import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:word_app/models/word_model.dart';
import 'package:word_app/models/word_list_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'word_app.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE wordListsInfos('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'wordListId TEXT UNIQUE NOT NULL,'
          'wordListName TEXT NOT NULL,'
          'wordCount INTEGER NOT NULL,'
          'isDownloaded INTEGER DEFAULT 0'
          ')',
        );
        db.execute(
          'CREATE TABLE words('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'wordListId TEXT NOT NULL,'
          'word TEXT NOT NULL,'
          'meaning1 TEXT NOT NULL,'
          'meaning2 TEXT,'
          'meaning3 TEXT,'
          'FOREIGN KEY(wordListId) REFERENCES wordListsInfos(wordListId)'
          ')',
        );
      },
      version: 4,
    );
  }

  Future<void> insertWord(
      {required word_model wordModel, required wordListId}) async {
    final db = await database;
    await db.insert(
      'words',
      wordModel.toJson(wordListId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertWordListInfo(
      {required word_list_model wordListModel}) async {
    final db = await database;
    await db.insert(
      'wordListsInfos',
      wordListModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateWordListAsDownloaded(
      {required String wordListId}) async {
    final db = await database;
    await db.update(
      'wordListsInfos',
      {'isDownloaded': 1},
      where: 'wordListId = ?',
      whereArgs: [wordListId],
    );
  }

  Future<int> getListsWordsCount({required String wordListName}) async {
    final db = await database;
    final result = await db.query(
      'words',
      where: 'wordListId = ?',
      whereArgs: [wordListName],
    );
    return result.length;
  }

  Future<Map<String, dynamic>> getMeaningByWord(String word) async {
    final db = await database;
    final result = await db.query(
      'words',
      where: 'word = ?',
      whereArgs: [word],
    );
    return result[0];
  }

  Future<Object?> isWordListsAlreadyDownloaded(String wordListId) async {
    final db = await database;
    final result = await db.query('wordListsInfos',
        where: 'wordListId = ?', whereArgs: [wordListId]);
    return result[0]['isDownloaded'];
  }

  Future<bool> isWordListsInfoAlreadyExist(String wordListId) async {
    final db = await database;
    final result = await db.query('wordListsInfos',
        where: 'wordListId = ?', whereArgs: [wordListId]);
    return result.isEmpty;
  }

  Future<List<Map<String, dynamic>>> getDownloadedWordListsInfos() async {
    final db = await database;
    return await db
        .query('wordListsInfos', where: 'isDownloaded = ?', whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> getDownloadableWordListsInfos() async {
    final db = await database;
    return await db
        .query('wordListsInfos', where: 'isDownloaded = ?', whereArgs: [0]);
  }

  Future<List<Map<String, dynamic>>> getAllWords() async {
    final db = await database;
    return await db.query('words');
  }

  Future<List<Map<String, dynamic>>> getAllListsWords(
      String wordListId) async {
    final db = await database;
    return await db.query(
      'words',
      where: 'wordListId = ?',
      whereArgs: [wordListId],
    );
  }

  Future<int> deleteAllWords() async {
    final db = await database;
    await db.delete('wordListsInfos');
    return await db.delete('words');
  }

  Future<List<Map<String, dynamic>>> getRandomWords({required count}) async {
    final db = await database;
    return await db.query(
      'words',
      orderBy: 'RANDOM()',
      limit: count,
    );
  }

  Future<List<Map<String, dynamic>>> getRandomWordsFromList(
      {required wordListId, count}) async {
    final db = await database;
    return await db.query(
      'words',
      where: 'wordListId = ?',
      whereArgs: [wordListId],
      orderBy: 'RANDOM()',
      limit: count,
    );
  }
}
