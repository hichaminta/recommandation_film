import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user_model.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const int MAX_LOGIN_ATTEMPTS = 5;
  static const int LOCKOUT_DURATION_MINUTES = 30;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Ajouter les colonnes pour la gestion des tentatives de connexion
      await db.execute('''
        ALTER TABLE users ADD COLUMN login_attempts INTEGER DEFAULT 0
      ''');
      await db.execute('''
        ALTER TABLE users ADD COLUMN last_attempt_time INTEGER
      ''');
      await db.execute('''
        ALTER TABLE users ADD COLUMN salt TEXT
      ''');
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        salt TEXT NOT NULL,
        username TEXT NOT NULL,
        login_attempts INTEGER DEFAULT 0,
        last_attempt_time INTEGER
      )
    ''');
  }

  // Génère un salt aléatoire
  String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(bytes);
  }

  // Hash le mot de passe avec le salt
  String _hashPassword(String password, String salt) {
    final key = utf8.encode(password);
    final saltBytes = utf8.encode(salt);
    final hmac = Hmac(sha256, saltBytes);
    final digest = hmac.convert(key);
    return digest.toString();
  }

  Future<int> createUser(User user) async {
    final db = await instance.database;
    
    // Générer un salt unique pour ce user
    final salt = _generateSalt();
    // Hasher le mot de passe avec le salt
    final passwordHash = _hashPassword(user.password, salt);
    
    final userData = {
      'email': user.email,
      'password_hash': passwordHash,
      'salt': salt,
      'username': user.username,
      'login_attempts': 0,
      'last_attempt_time': null
    };
    
    return await db.insert('users', userData);
  }

  Future<bool> isUserLocked(String email) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isEmpty) return false;

    final int attempts = result.first['login_attempts'] ?? 0;
    final int? lastAttemptTime = result.first['last_attempt_time'];

    if (attempts >= MAX_LOGIN_ATTEMPTS && lastAttemptTime != null) {
      final DateTime lastAttempt = DateTime.fromMillisecondsSinceEpoch(lastAttemptTime);
      final Duration difference = DateTime.now().difference(lastAttempt);
      
      if (difference.inMinutes < LOCKOUT_DURATION_MINUTES) {
        return true;
      } else {
        // Réinitialiser le compteur après la période de verrouillage
        await db.update(
          'users',
          {'login_attempts': 0, 'last_attempt_time': null},
          where: 'email = ?',
          whereArgs: [email],
        );
      }
    }
    return false;
  }

  Future<User?> getUser(String email, String password) async {
    final db = await instance.database;
    
    // Vérifier si le compte est verrouillé
    if (await isUserLocked(email)) {
      throw Exception('Compte temporairement verrouillé. Réessayez plus tard.');
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isEmpty) {
      await _incrementLoginAttempts(email);
      return null;
    }

    final userData = maps.first;
    final storedHash = userData['password_hash'];
    final salt = userData['salt'];
    final attemptedHash = _hashPassword(password, salt);

    if (attemptedHash == storedHash) {
      // Réinitialiser les tentatives en cas de succès
      await db.update(
        'users',
        {'login_attempts': 0, 'last_attempt_time': null},
        where: 'email = ?',
        whereArgs: [email],
      );
      
      return User(
        id: userData['id'],
        email: userData['email'],
        password: '', // Ne jamais renvoyer le mot de passe
        username: userData['username'],
      );
    } else {
      await _incrementLoginAttempts(email);
      return null;
    }
  }

  Future<void> _incrementLoginAttempts(String email) async {
    final db = await instance.database;
    await db.rawUpdate('''
      UPDATE users 
      SET login_attempts = login_attempts + 1,
          last_attempt_time = ?
      WHERE email = ?
    ''', [DateTime.now().millisecondsSinceEpoch, email]);
  }

  Future<bool> isEmailExists(String email) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.isNotEmpty;
  }
} 