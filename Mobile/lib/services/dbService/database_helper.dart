import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:word_app/models/word.dart';
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
          'CREATE TABLE words(id INTEGER PRIMARY KEY AUTOINCREMENT, wordListName TEXT, word TEXT, meaning1 TEXT, meaning2 TEXT, meaning3 TEXT)',
        );
        db.execute(
          'CREATE TABLE wordListsInfos(id INTEGER PRIMARY KEY AUTOINCREMENT, wordListName TEXT,wordCount INTEGER,isDownloaded INTEGER DEFAULT 0)',
        );
      },
      version: 3,
    );
  }

  Future<void> insertWord(
      {required word_model wordModel, required wordListName}) async {
    final db = await database;
    await db.insert(
      'words',
      {
        'wordListName': wordListName,
        'word': wordModel.word,
        'meaning1': wordModel.meaning1,
        'meaning2': wordModel.meaning2 ?? '',
        'meaning3': wordModel.meaning3 ?? '',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertWordListInfo(
      {required word_list_model wordListModel}) async {
    final db = await database;
    await db.insert(
      'wordListsInfos',
      {'wordListName': wordListModel.wordListName, 'wordCount': wordListModel.wordCount},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateWordListAsDownloaded(
      {required String wordListName}) async {
    final db = await database;
    await db.update(
      'wordListsInfos',
      {'isDownloaded': 1},
      where: 'wordListName = ?',
      whereArgs: [wordListName],
    );
  }

  Future<int> getListsWordsCount({required String wordListName}) async {
    final db = await database;
    final result = await db.query(
      'words',
      where: 'wordListName = ?',
      whereArgs: [wordListName],
    );
    return result.length;
  }

  Future<List<Map<String, dynamic>>> getMeaningByWord(String word) async {
    final db = await database;
    final result = await db.query(
      'words',
      where: 'word = ?',
      whereArgs: [word],
    );
    return result;
  }

  Future<Object?> isWordListsAlreadyDownloaded(String wordListName) async {
    final db = await database;
    final result=await db
        .query('wordListsInfos', where: 'wordListName = ?', whereArgs: [wordListName]);
    return result[0]['isDownloaded'];
  }
  Future<bool> isWordListsInfoAlreadyExist(String wordListName) async {
    final db = await database;
    final result=await db
        .query('wordListsInfos', where: 'wordListName = ?', whereArgs: [wordListName]);
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
      String wordListName) async {
    final db = await database;
    return await db.query(
      'words',
      where: 'wordListName = ?',
      whereArgs: [wordListName],
    );
  }

  Future<int> deleteAllWords() async {
    final db = await database;
    db.delete('wordListsInfos');
    return await db.delete('words');
  }

  Future<List<Map<String, dynamic>>> getRandomWords(
      {required count}) async {
    final db = await database;
    return await db.query(
      'words',
      orderBy: 'RANDOM()',
      limit: count,
    );
  }

  Future<List<Map<String, dynamic>>> getRandomWordsFromList(
      {required wordListName, count}) async {
    final db = await database;
    return await db.query(
      'words',
      where: 'wordListName = ?',
      whereArgs: [wordListName],
      orderBy: 'RANDOM()',
      limit: count,
    );
  }
}
