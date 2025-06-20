import 'package:dt02_nhom09/class/Registrationshift.dart';
import 'package:dt02_nhom09/class/area.dart';
import 'package:dt02_nhom09/class/categories.dart';
import 'package:dt02_nhom09/class/listFood.dart';
import 'package:dt02_nhom09/class/order_detail.dart';
import 'package:dt02_nhom09/class/order_model.dart';
import 'package:dt02_nhom09/class/shift.dart';
import 'package:dt02_nhom09/class/table_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dt02_nhom09/class/user.dart';
import 'package:intl/intl.dart';

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

    print('Opening database at $path');
    // await deleteDatabase(path);
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
          CREATE TABLE Shifts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            shiftname TEXT,
            start_time TEXT,
            end_time TEXT,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        //Bảng khu vực (area)
        await db.execute('''
          CREATE TABLE Areas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');

        // Bảng table (bàn ăn)
        await db.execute('''
          CREATE TABLE Tables(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            seat_count INTEGER,
            status TEXT,
            price REAL,
            area_id INTEGER,
            created_at TEXT,
            updated_at TEXT,
            FOREIGN KEY(area_id) REFERENCES Areas(id)
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
            updated_at TEXT,
            FOREIGN KEY(shift_id) REFERENCES Shifts(id),
            FOREIGN KEY(staff_id) REFERENCES users(id),
            FOREIGN KEY(table_id) REFERENCES Tables(id) 
          );
        ''');

        // Bảng category
        await db.execute('''
          CREATE TABLE Categories(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            created_at TEXT,
            updated_at TEXT
          );
        ''');

        // Bảng dish (món ăn)
        await db.execute('''
          CREATE TABLE Dishes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            image_url TEXT,
            category_id INTEGER,
            status TEXT,
            rating REAL,
            ratingCount INTEGER,
            created_at TEXT,
            updated_at TEXT,
            FOREIGN KEY(category_id) REFERENCES Categories(id)
          );
        ''');

        // Bảng orders
        await db.execute('''
          CREATE TABLE Orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_id INTEGER,
            staff_id INTEGER,
            table_id INTEGER,
            status TEXT,
            total_amount REAL,
            note TEXT,
            created_at TEXT,
            updated_at TEXT,
            FOREIGN KEY(customer_id) REFERENCES users(id),
            FOREIGN KEY(staff_id) REFERENCES users(id)
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
            chef_id INTEGER,
            created_at TEXT,
            updated_at TEXT,
            FOREIGN KEY(order_id) REFERENCES Orders(id),
            FOREIGN KEY(dish_id) REFERENCES Dishes(id),
            FOREIGN KEY(chef_id) REFERENCES users(id)
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

        //Khách
        await db.insert('users', {
          'username': 'tuan',
          'password': '12345',
          'fullname': 'Nguyễn Văn Tuấn',
          'role': 'Khách',
          'phone': '0112657934',
          'email': 'tuan@gmail.com',
          'address': 'Quận 5',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        //Bếp
        await db.insert('users', {
          'username': 'vu',
          'password': '12345',
          'fullname': 'Nguyễn Tuấn Vũ',
          'role': 'Bếp',
          'phone': '0112657934',
          'email': 'vu@gmail.com',
          'address': 'Quận 5',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        await db.insert('users', {
          'username': 'khanh',
          'password': '12345',
          'fullname': 'Nguyễn Phương Khánh',
          'role': 'Bếp',
          'phone': '0112657934',
          'email': 'khanh@gmail.com',
          'address': 'Quận 5',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        //categories dishes
        await db.insert('Categories', {
          'name': 'Món ăn chính',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Categories', {
          'name': 'Đồ uống',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Categories', {
          'name': 'Món tráng miệng',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        //insert dishes
        await db.insert('Dishes', {
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
        await db.insert('Dishes', {
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
        await db.insert('Dishes', {
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

        //areas
        await db.insert('Areas', {'name': 'Ngoài trời'});

        await db.insert('Areas', {'name': 'Trong nhà'});

        await db.insert('Areas', {'name': 'Sự kiện'});

        await db.insert('Areas', {'name': 'Phòng chờ'});

        //shifts
        await db.insert('Shifts', {
          'shiftname': 'Ca sáng',
          'start_time': '08:00',
          'end_time': '13:00',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Shifts', {
          'shiftname': 'Ca chiều',
          'start_time': '13:00',
          'end_time': '18:00',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Shifts', {
          'shiftname': 'Ca tối',
          'start_time': '18:30',
          'end_time': '23:59',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        //Tables
        await db.insert('Tables', {
          'seat_count': 4,
          'status': 'Trống',
          'price': 150000,
          'area_id': 1,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Tables', {
          'seat_count': 8,
          'status': 'Trống',
          'price': 150000,
          'area_id': 2,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Tables', {
          'seat_count': 2,
          'status': 'Trống',
          'price': 100000,
          'area_id': 2,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Tables', {
          'seat_count': 10,
          'status': 'Trống',
          'price': 300000,
          'area_id': 3,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Tables', {
          'seat_count': 10,
          'status': 'Đang dùng',
          'price': 200000,
          'area_id': 4,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('Tables', {
          'seat_count': 12,
          'status': 'Đã đặt',
          'price': 500000,
          'area_id': 2,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        //Staff enroll shift by area
        await db.insert('StaffShiftArea', {
          'shift_id': 1, // Ca sáng
          'staff_id': 3, // nv1
          'table_id': 1,
          'created_at': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('StaffShiftArea', {
          'shift_id': 1, // Ca sáng
          'staff_id': 3, // nv1
          'table_id': 2,
          'created_at': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('StaffShiftArea', {
          'shift_id': 2, // Ca sáng
          'staff_id': 3, // nv1
          'table_id': 3,
          'created_at': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'updated_at': DateTime.now().toIso8601String(),
        });
        await db.insert('StaffShiftArea', {
          'shift_id': 3, // Ca sáng
          'staff_id': 3, // nv1
          'table_id': 3,
          'created_at': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'updated_at': DateTime.now().toIso8601String(),
        });

        // Thêm dữ liệu mẫu cho bảng Orders
        await db.insert('Orders', {
          'customer_id': 5, // Ví dụ khách hàng có ID là 5
          'staff_id': 3, // Nhân viên xử lý đơn hàng có ID là 3
          'table_id': 1,
          'status': 'Đang xử lý',
          'total_amount': 150000, // Tổng số tiền đơn hàng
          'note': 'Đặt món ăn cho bàn số 1',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        // Thêm dữ liệu mẫu cho bảng OrderDetail
        await db.insert('OrderDetail', {
          'order_id': 1, // Ví dụ đơn hàng có ID là 1
          'dish_id': 1, // Món ăn có ID là 1 (ví dụ: Phở bò)
          'quantity': 2, // Số lượng món ăn trong đơn hàng
          'status': 'Đang chế biến',
          'chef_id': 6,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        // Thêm dữ liệu mẫu cho bảng OrderDetail khác
        await db.insert('OrderDetail', {
          'order_id': 1,
          'dish_id': 3,
          'quantity': 1,
          'status': 'Chờ chế biến',
          'chef_id': 7,
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
    final List<Map<String, dynamic>> maps = await db.query('Categories');
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  //dishes
  Future<List<Dish>> getAllDishes() async {
    final db = await database;
    final maps = await db.query('Dishes');
    return List.generate(maps.length, (i) => Dish.fromMap(maps[i]));
  }

  Future<List<Dish>> getDishesByCategory(int categoryId) async {
    final db = await database;
    final maps = await db.query(
      'Dishes',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    return List.generate(maps.length, (i) => Dish.fromMap(maps[i]));
  }

  //insert new dish
  Future<int> insertDish(Dish dish) async {
    final db = await database;
    return await db.insert(
      'Dishes',
      dish.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //areas
  Future<List<Area>> getAllAreas() async {
    final db = await database;
    final maps = await db.query('Areas');
    return List.generate(maps.length, (i) => Area.fromMap(maps[i]));
  }

  //Filter table by area id
  Future<List<TableModel>> getTablesByArea(int areaId) async {
    final db = await database;
    final maps = await db.query(
      'Tables',
      where: 'area_id = ?',
      whereArgs: [areaId],
    );
    return List.generate(maps.length, (i) => TableModel.fromMap(maps[i]));
  }

  //get all shift
  Future<List<Shift>> getAllShifts() async {
    final db = await database;
    final maps = await db.query('Shifts');
    return List.generate(maps.length, (i) => Shift.fromMap(maps[i]));
  }

  //get all registation shift marked
  Future<List<Registrationshift>> getAllRegistrationShift() async {
    final db = await database;
    final maps = await db.query('StaffShiftArea');
    return List.generate(
      maps.length,
      (i) => Registrationshift.fromMap(maps[i]),
    );
  }

  Future<List<Registrationshift>> getResgistShiftByStaffId(int staffId) async {
    final db = await database;
    final maps = await db.query(
      'StaffShiftArea',
      where: 'staff_id = ?',
      whereArgs: [staffId],
    );
    return List.generate(
      maps.length,
      (i) => Registrationshift.fromMap(maps[i]),
    );
  }

  Future<List<TableModel>> getTablesWithAreaNameByAreaId(int areaId) async {
    final db = await database;
    final results = await db.rawQuery(
      '''
    SELECT Tables.id, Tables.seat_count, Tables.status, Tables.price,
           Tables.area_id, Tables.created_at, Tables.updated_at,
           Areas.name AS area_name
    FROM Tables
    INNER JOIN Areas ON Tables.area_id = Areas.id
    WHERE Tables.area_id = ?
  ''',
      [areaId],
    );

    // return results;
    return results.map((row) => TableModel.fromJoinedMap(row)).toList();
  }

  Future<String?> getAreaNameById(int areaId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Areas',
      where: 'id = ?',
      whereArgs: [areaId],
    );

    if (result.isNotEmpty) {
      return result.first['name'];
    } else {
      return null;
    }
  }

  //test
  Future<List<Map<String, dynamic>>> getTodayShiftsByRole(String role) async {
    final db = await database;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final rows = await db.rawQuery(
      '''
    SELECT ssa.id                 AS id,
           ssa.table_id,
           a.name                 AS areaName,
           ssa.shift_id,
           u.fullname             AS staffName,
           u.id                   AS staff_id,
           sh.shiftname,
           sh.start_time,
           sh.end_time
    FROM   StaffShiftArea ssa
    JOIN   users u      ON u.id      = ssa.staff_id
    JOIN   Shifts sh    ON sh.id     = ssa.shift_id
    JOIN   Tables t     ON t.id      = ssa.table_id
    JOIN   Areas a      ON a.id      = t.area_id
    WHERE  date(ssa.created_at) = ?      -- NGÀY làm việc
       AND u.role              = ?
    ORDER  BY sh.start_time
    ''',
      [today, role],
    );

    return rows;
  }

  Future<List<Map<String, dynamic>>> getTodayShiftsByStaff(int staffId) async {
    final db = await database;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final rows = await db.rawQuery(
      '''
    SELECT ssa.id             AS id,
           ssa.table_id,
           a.name                 AS areaName,
           ssa.shift_id,
           sh.shiftname,
           sh.start_time,
           sh.end_time
    FROM   StaffShiftArea ssa
    JOIN   Shifts sh ON sh.id = ssa.shift_id
    JOIN   Tables t     ON t.id      = ssa.table_id
    JOIN   Areas a      ON a.id      = t.area_id
    WHERE  date(ssa.created_at) = ?
       AND ssa.staff_id         = ?
    ORDER  BY sh.start_time
  ''',
      [today, staffId],
    );

    return rows;
  }

  Future<int> insertStaffShiftArea(Registrationshift resg) async {
    final db = await database;

    return await db.insert(
      'StaffShiftArea',
      resg.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Area>> getAreasInTodayShiftByStaff(int staffId) async {
    final db = await database;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final now = DateFormat('HH:mm').format(DateTime.now());
    final shift = await db.rawQuery(
      '''
      SELECT id
      FROM   Shifts
      WHERE  time(?) BETWEEN start_time AND end_time
      LIMIT  1
  ''',
      [now],
    );

    if (shift.isEmpty) return [];

    final shiftId = shift.first['id'] as int;

    final rows = await db.rawQuery(
      '''
    SELECT DISTINCT a.id, a.name
    FROM   StaffShiftArea ssa
    JOIN   Tables t ON t.id   = ssa.table_id
    JOIN   Areas  a ON a.id   = t.area_id
    JOIN   Shifts sh  a ON sh.id   = ssa.shift_id
    WHERE  ssa.staff_id       = ?
      AND  ssa.shift_id       = ?
      AND  time(?) BETWEEN sh.start_time AND sh.end_time
  ''',
      [staffId, shiftId, today],
    );

    return rows.map((m) => Area.fromMap(m)).toList();
  }

  Future<List<Map<String, dynamic>>> getOrderWithUserInfo() async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT 
      o.id,
      o.customer_id,
      cu.fullname AS customerName,
      o.staff_id,
      st.fullname AS staffName,
      o.table_id,
      ar.name AS areaName,
      o.status,
      o.total_amount,
      o.note
    FROM Orders o
    LEFT JOIN users cu ON o.customer_id = cu.id
    LEFT JOIN users st ON o.staff_id = st.id
    JOIN Tables t ON t.id = o.table_id
    JOIN Areas ar ON ar.id = t.area_id

  ''');

    return result;
  }

  Future<Map<String, dynamic>?> getOrderById(int id) async {
    final dbClient = await database;
    final result = await dbClient.query(
      'Orders',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getOrderWithUserInfoByIdOrder(
    int orderId,
  ) async {
    final db = await database;

    final result = await db.rawQuery(
      '''
    SELECT 
      o.id,
      o.customer_id,
      cu.fullname AS customerName,
      o.staff_id,
      st.fullname AS staffName,
      o.table_id,
      ar.name AS areaName,
      o.status,
      o.total_amount,
      o.note
    FROM Orders o
    LEFT JOIN users cu ON o.customer_id = cu.id
    LEFT JOIN users st ON o.staff_id = st.id
    JOIN Tables t ON t.id = o.table_id
    JOIN Areas ar ON ar.id = t.area_id
    Where o.id = ?
    ''',
      [orderId],
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> getOrderDetailsByOrderId(
    int orderId,
  ) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
    SELECT 
      od.id,
      od.order_id, 
      od.dish_id, 
      d.name AS dish_name, 
      od.quantity, 
      od.status, 
      od.chef_id, 
      u.fullName AS chef_name
    FROM OrderDetail od
    JOIN Orders o ON od.order_id = o.id
    JOIN Dishes d ON od.dish_id = d.id
    LEFT JOIN users u ON od.chef_id = u.id
    WHERE od.order_id = ?
  ''',
      [orderId],
    );

    return result;
  }

  // Thêm vào DatabaseHelper
  Future<List<Area>> getAreasForStaffCurrentShift(int staffId) async {
    final db = await database;

    final nowStr = DateFormat('HH:mm').format(DateTime.now());

    final rows = await db.rawQuery(
      '''
    SELECT DISTINCT a.id, a.name
    FROM   StaffShiftArea  ssa
    JOIN   Shifts          sh ON sh.id = ssa.shift_id
    JOIN   Tables          t  ON t.id  = ssa.table_id
    JOIN   Areas           a  ON a.id  = t.area_id
    WHERE  ssa.staff_id    = ?
      AND  time(?) BETWEEN time(sh.start_time) AND time(sh.end_time)
  ''',
      [staffId, nowStr],
    );

    return rows.map((m) => Area.fromMap(m)).toList();
  }

  Future<List<TableModel>> getTablesForStaffCurrentShift(int staffId) async {
    final db = await database;
    final nowStr = DateFormat('HH:mm').format(DateTime.now());

    final rows = await db.rawQuery(
      '''
    SELECT t.*
    FROM   StaffShiftArea ssa
    JOIN   Shifts         sh ON sh.id = ssa.shift_id
    JOIN   Tables         t  ON t.id  = ssa.table_id
    WHERE  ssa.staff_id   = ?
      AND  time(?) BETWEEN time(sh.start_time) AND time(sh.end_time)
  ''',
      [staffId, nowStr],
    );

    return rows.map((m) => TableModel.fromMap(m)).toList();
  }

  Future<List<Map<String, dynamic>>> getShiftsOfStaff(int staffId) async {
    final db = await database;

    final result = await db.rawQuery(
      '''
    SELECT 
      s.shiftname,
      s.start_time,
      s.end_time,
      sa.created_at
    FROM StaffShiftArea sa
    JOIN Shifts s ON sa.shift_id = s.id
    WHERE sa.staff_id = ?
    ORDER BY sa.created_at DESC
  ''',
      [staffId],
    );

    return result;
  }

  //hiển thị một lịch theo ngày + giờ làm
  Future<Map<String, dynamic>?> getTodayScheduleAndArea(int staffId) async {
    final db = await database;
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    // final currentTime = now;
    final currentTime = DateFormat('HH:mm').format(now);
    final result = await db.rawQuery(
      '''
     SELECT s.table_id, sh.start_time, sh.end_time, sh.created_at,
           t.area_id, a.name as area_name
    FROM StaffShiftArea s
    JOIN Tables t ON s.table_id = t.id
    JOIN Areas a ON t.area_id = a.id
    JOIN Shifts sh ON s.shift_id = sh.id
    WHERE s.staff_id = ?
      AND s.created_at = ?
      AND  time(?) BETWEEN time(sh.start_time) AND time(sh.end_time)

  ''',
      [staffId, today, currentTime],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<Area?> getAreaById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'Areas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Area.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<TableModel?> getTableById(int id) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'Tables',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return TableModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  //insert order
  Future<int> insertOrder(Order order) async {
    final db = await database;
    final orderMap = {
      'customer_id': order.customer_id,
      'staff_id': order.staffId,
      'table_id': order.table_id,
      'status': order.status,
      'total_amount': order.totalAmount,
      'note': order.note,
      'created_at': order.createdAt.toIso8601String(),
      'updated_at': order.updatedAt.toIso8601String(),
    };

    return await db.insert('Orders', orderMap);
  }

  //insert order detail
  Future<void> insertOrderDetails(List<OrderDetail> details) async {
    final db = await database;
    for (final detail in details) {
      await db.insert('OrderDetail', detail.toMap());
    }
  }

  Future<String?> getNameAreaById(int areaId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Areas',
      columns: ['name'],
      where: 'id = ?',
      whereArgs: [areaId],
    );

    if (result.isNotEmpty) {
      return result.first['name'] as String;
    } else {
      return null;
    }
  }

  Future<User?> findUserBySDT(String sdt) async {
    final db = await database;
    final result = await db.query(
      'Users',
      where: 'phone = ?',
      whereArgs: [sdt],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  //show dishes prepare

  // Future<List<Map<String, dynamic>>> getDishesToPrepare() async {
  //   final db = await database;
  //   final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //   final result = await db.rawQuery(
  //     '''
  //   SELECT od.id, d.name AS dish_name, od.quantity, od.status
  //   FROM OrderDetail od
  //   JOIN Dishes d ON od.dish_id = d.id
  //   WHERE DATE(od.created_at) = ?
  //     AND od.chef_id IS NULL
  //   ''',
  //     [today],
  //   );

  //   return result;
  // }

  Future<List<Map<String, dynamic>>> getDishesToPrepare() async {
    final db = await database;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final result = await db.rawQuery(
      '''
    SELECT od.id, d.name AS dish_name, od.quantity, od.status, o.note as note, o.id as orderId
    FROM OrderDetail od
    JOIN Dishes d ON od.dish_id = d.id
    JOIN Orders o ON od.order_id = o.id
    WHERE DATE(od.created_at) = ?
      AND od.chef_id IS NULL
    ''',
      [today],
    );

    return result;
  }

  Future<void> updateOrderDetailStatus(
    int orderDetailId,
    String newStatus,
  ) async {
    final db = await database;

    await db.update(
      'OrderDetail',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [orderDetailId],
    );

    // 2. Lấy order_id của order detail vừa cập nhật
    final List<Map<String, dynamic>> result = await db.query(
      'OrderDetail',
      columns: ['order_id'],
      where: 'id = ?',
      whereArgs: [orderDetailId],
      limit: 1,
    );

    if (result.isEmpty) return;

    final int orderId = result[0]['order_id'];

    await db.rawUpdate(
      '''
      UPDATE Orders
        SET status = CASE
          WHEN NOT EXISTS (
            SELECT 1 FROM OrderDetail od
            WHERE od.order_id = Orders.id AND od.status != 'Hoàn thành'
          ) THEN 'Hoàn thành'
          WHEN EXISTS (
            SELECT 1 FROM OrderDetail od
            WHERE od.order_id = Orders.id AND od.status = 'Đang chế biến'
          ) THEN 'Đang chế biến'
          ELSE 'Chờ xử lý'
        END
        WHERE id = ?;
      ''',
      [orderId],
    );
  }

  Future<void> updateOrderDetailChef(int orderDetailId, int chefId) async {
    final dbClient = await database;
    await dbClient.update(
      'OrderDetail',
      {'chef_id': chefId},
      where: 'id = ?',
      whereArgs: [orderDetailId],
    );
  }
}
