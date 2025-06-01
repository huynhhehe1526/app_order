import 'package:dt02_nhom09/class/categories.dart';
import 'package:dt02_nhom09/class/listFood.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dt02_nhom09/class/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'restaurant_app.db');

    print('Opening database at $path'); // Debug thêm

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Bảng user
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT,
            fullname TEXT,
            role TEXT,
            phone TEXT,
            email TEXT,
            address TEXT,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        // Bảng shift (ca làm việc)
        await db.execute('''
          CREATE TABLE Shift(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            shiftname TEXT,
            start_time TEXT,
            end_time TEXT,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        // Bảng table (bàn ăn)
        await db.execute('''
          CREATE TABLE TableInfo(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            seat_count INTEGER,
            status TEXT,
            area_name TEXT,
            price REAL,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        // Bảng staff_shift_area (đăng ký ca làm)
        await db.execute('''
          CREATE TABLE StaffShiftArea(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            shift_id INTEGER,
            staff_id INTEGER,
            table_id INTEGER,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        // Bảng category
        await db.execute('''
          CREATE TABLE Category(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        // Bảng dish (món ăn)
        await db.execute('''
          CREATE TABLE Dish(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            image_url TEXT,
            category_id INTEGER,
            status TEXT,
            rating REAL,
            ratingCount INTEGER,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        // Bảng orders
        await db.execute('''
          CREATE TABLE Orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_id INTEGER,
            staff_id INTEGER,
            status TEXT,
            total_amount REAL,
            note TEXT,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        // Bảng order_detail
        await db.execute('''
          CREATE TABLE OrderDetail(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            order_id INTEGER,
            dish_id INTEGER,
            quantity INTEGER,
            status TEXT,
            chef_id INTEGER
          );
        ''');

        //insert data
        //users
        await db.insert('users', {
          'username': 'admin1',
          'password': '1234',
          'fullname': 'Nguyễn Sơn',
          'role': 'Quản lý',
          'phone': '0123687435',
          'email': 'quanly1@gmail.com',
          'address': 'TP Hồ Chí Minh',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('users', {
          'username': 'admin2',
          'password': '1234',
          'fullname': 'Phạm Văn Hai',
          'role': 'Quản lý',
          'phone': '01262236945',
          'email': 'quanly2@gmail.com',
          'address': 'Vũng Tàu',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        await db.insert('users', {
          'username': 'nv1',
          'password': '12345',
          'fullname': 'Nguyễn Văn Nam',
          'role': 'Nhân viên',
          'phone': '0112233445',
          'email': 'nv1@gmail.com',
          'address': 'Quận 8',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        await db.insert('users', {
          'username': 'nv2',
          'password': '12345',
          'fullname': 'Trần Thị Nữ',
          'role': 'Nhân viên',
          'phone': '0112657934',
          'email': 'nv2@gmail.com',
          'address': 'Quận Tân Phú',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        //categories dishes
        await db.insert('Category', {
          'name': 'Món ăn chính',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Category', {
          'name': 'Đồ uống',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Category', {
          'name': 'Món tráng miệng',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        //insert dishes
        await db.insert('Dish', {
          'name': 'Phở bò',
          'price': 50000,
          'image_url': 'assets/images/pho_bo.jpg',
          'category_id': 1,
          'status': 'Còn',
          'rating': 4.5,
          'ratingCount': 124,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Dish', {
          'name': 'Bánh Flan',
          'price': 25000,
          'image_url': 'assets/images/banh_flan.jpg',
          'category_id': 3,
          'status': 'Sắp hết',
          'rating': 4.2,
          'ratingCount': 89,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Dish', {
          'name': 'Trà Đào',
          'price': 35000,
          'image_url': 'assets/images/tra_dao.jpg',
          'category_id': 2,
          'status': 'Còn',
          'rating': 4.0,
          'ratingCount': 45,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      },
    );
  }

  Future<User?> getUserById(int id) async {
    final db = await database; // database là getter trả về Database object
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // Lấy danh sách tất cả user để quản lý
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Xóa user theo id
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // Thêm user mới
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  // Lấy user theo username (để check tồn tại)
  Future<User?> getUserByUsername(String username) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserByUsernameAndPassword(
    String username,
    String password,
  ) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<bool> isUsernameExists(String username) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty;
  }

  Future<void> insertDefaultManager() async {
    final db = await database;

    // Kiểm tra nếu chưa có tài khoản "Quản lý" thì mới thêm
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'role = ?',
      whereArgs: ['Quản lý'],
    );
  }

  //category
  Future<List<Category>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Category');
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  //dishes
  Future<List<Dish>> getAllDishes() async {
    final db = await database;
    final maps = await db.query('Dish');
    return List.generate(maps.length, (i) => Dish.fromMap(maps[i]));
  }

  Future<List<Dish>> getDishesByCategory(int categoryId) async {
    final db = await database;
    final maps = await db.query(
      'Dish',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    return List.generate(maps.length, (i) => Dish.fromMap(maps[i]));
  }

  //insert new dish
  Future<int> insertDish(Dish dish) async {
    final db = await database;
    return await db.insert(
      'Dish',
      dish.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
