import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Bảng user
        await db.execute('''
          CREATE TABLE User(
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
      },
    );
  }
}
