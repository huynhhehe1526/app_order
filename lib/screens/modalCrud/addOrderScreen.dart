// //test db
// import 'package:dt02_nhom09/class/area.dart';
// import 'package:dt02_nhom09/class/listFood.dart';
// import 'package:dt02_nhom09/class/order_detail.dart';
// import 'package:dt02_nhom09/class/order_model.dart';
// import 'package:dt02_nhom09/class/table_model.dart';
// import 'package:dt02_nhom09/class/user.dart';
// import 'package:dt02_nhom09/db/db_helper.dart';
// import 'package:dt02_nhom09/screens/menu.dart';
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// // import '../data/mock_data.dart';
// import 'package:dt02_nhom09/screens/order_mode.dart';

// class AddOrderScreen extends StatefulWidget {
//   final OrderMode mode;
//   final int id;
//   final String name;
//   final String role;

//   const AddOrderScreen({
//     super.key,
//     required this.mode,
//     required this.id,
//     required this.name,
//     required this.role,
//   });

//   @override
//   State<AddOrderScreen> createState() => _AddOrderScreenState();
// }

// class _AddOrderScreenState extends State<AddOrderScreen> {
//   /* ---------- controller & state chung ---------- */
//   final _noteController = TextEditingController();
//   int? selectedAreaId;
//   int? selectedTableId;
//   TimeOfDay? _selectedTime; // chỉ dùng cho khách / quản lý
//   final Map<String, int> _selectedDishes = {}; // dishName -> qty
//   List<Map<String, dynamic>> filteredTables = [];
//   //thông tin khách
//   final _customerNameController = TextEditingController();
//   final _customerPhoneController = TextEditingController();
//   /* ---------- flag & dữ liệu riêng cho staff ---------- */
//   late final bool isStaff;
//   late final bool isManage;
//   int? staffId;
//   // List<Map<String, dynamic>> staffTables = [];
//   Set<int> staffTables = {};
//   Set<int> staffAreas = {};

//   List<Area> _listAreas = [];
//   //table by areaId
//   List<TableModel> _listTables = [];
//   DatabaseHelper db = DatabaseHelper();

//   List<Dish> listDishes = [];

//   /* ------------------------------------------------------------------ */
//   /*                              INIT                                  */
//   /* ------------------------------------------------------------------ */
//   @override
//   void initState() {
//     super.initState();
//     print('Check id: ${widget.id}, Name:${widget.name}, role: ${widget.role}');
//     isStaff = widget.role == 'Nhân viên';
//     isManage = widget.role == 'Quản lý';
//     _loadAreas();
//     _loadDishes();
//     // printStaffShifts();
//     // _loadShiftData();
//     if (isStaff) {
//       // _loadShiftData();
//       checkStaffSchedule(widget.id);
//     }

//     if (isStaff && selectedAreaId != null) _filterTables();
//   }

//   List<String> areaList = [];

//   String getShiftName(String start, String end) {
//     if (start == '08:00' && end == '13:00') return 'Ca sáng';
//     if (start == '13:00' && end == '18:00') return 'Ca chiều';
//     if (start == '18:00' && end == '23:00') return 'Ca tối';
//     return 'Ca khác';
//   }

//   void checkStaffSchedule(int staffId) async {
//     final data = await db.getTodayScheduleAndArea(staffId);

//     if (data != null) {
//       print('Ca: ${getShiftName(data['start_time'], data['end_time'])}');
//       print('Giờ bắt đầu: ${data['start_time']}');
//       print('Giờ kết thúc: ${data['end_time']}');
//       print('Ngày đăng ký: ${data['created_at']}');
//       print('Khu vực: ${data['area_name']}');

//       int areaId = data['area_id'];
//       int tableId = data['table_id'];
//       print('Check areaId trong hàm checkStaffSchedule: $areaId');
//       Area? area = await db.getAreaById(areaId);
//       print('Check areaId trong hàm checkStaffSchedule: $area');
//       if (area != null) {
//         setState(() {
//           _listAreas = [area];
//           staffAreas = {area.id!};
//           if (staffAreas.length == 1) selectedAreaId = staffAreas.first;
//         });
//       } else {
//         _listAreas = [];
//         staffAreas = {};
//       }

//       // Lấy bàn theo id
//       TableModel? table = await db.getTableById(tableId);

//       if (table != null) {
//         _listTables = [table];
//         staffTables = {table.id!};
//         if (staffTables.length == 1) selectedTableId = staffTables.first;
//       } else {
//         _listTables = [];
//         staffTables = {};
//       }

//       print('Bàn số: ${table?.id ?? 'Không có'}');
//     } else {
//       print('Hôm nay bạn không có ca làm hoặc không trong thời gian ca.');
//     }
//   }

//   String? selectedAreaName;

//   //đăng ký nhiều lịch
//   // void checkStaffSchedule(int staffId) async {
//   //   final dataList = await db.getTodayScheduleAndArea(staffId);

//   //   if (dataList != null && dataList.isNotEmpty) {
//   //     // Ví dụ xử lý ca làm đầu tiên (hoặc bạn có thể xử lý tất cả)
//   //     for (var data in dataList) {
//   //       print('Ca: ${getShiftName(data['start_time'], data['end_time'])}');
//   //       print('Giờ bắt đầu: ${data['start_time']}');
//   //       print('Giờ kết thúc: ${data['end_time']}');
//   //       print('Ngày đăng ký: ${data['created_at']}');
//   //       print('Khu vực: ${data['area_name']}');

//   //       int areaId = data['area_id'];
//   //       int tableId = data['table_id'];

//   //       Area? area = await db.getAreaById(areaId);
//   //       if (area != null) {
//   //         _listAreas = [area];
//   //         staffAreas = {area.id!};
//   //         if (staffAreas.length == 1) selectedAreaId = staffAreas.first;
//   //       } else {
//   //         _listAreas = [];
//   //         staffAreas = {};
//   //       }

//   //       // Lấy bàn theo id
//   //       TableModel? table = await db.getTableById(tableId);

//   //       if (table != null) {
//   //         _listTables = [table];
//   //         staffTables = {table.id!};
//   //         if (staffTables.length == 1) selectedTableId = staffTables.first;
//   //       } else {
//   //         _listTables = [];
//   //         staffTables = {};
//   //       }

//   //       print('Bàn số: ${table?.id ?? 'Không có'}');

//   //       print('--------------------'); // Dòng phân cách giữa các ca
//   //     }
//   //   } else {
//   //     print('Hôm nay bạn không có ca làm hoặc không trong thời gian ca.');
//   //   }
//   // }

//   // void printStaffShifts() async {
//   //   final shifts = await DatabaseHelper().getShiftsOfStaff(3);
//   //   for (var shift in shifts) {
//   //     print('Ca: ${shift['shiftname']}');
//   //     print('Giờ bắt đầu: ${shift['start_time']}');
//   //     print('Giờ kết thúc: ${shift['end_time']}');
//   //     print('Ngày đăng ký: ${shift['created_at']}');
//   //     print('---');
//   //   }
//   // }

//   //show all areas
//   Future<void> _loadAreas() async {
//     // ← thêm hàm
//     final lsarea = await db.getAllAreas();
//     setState(() => _listAreas = lsarea);
//   }

//   Future<void> _loadDishes() async {
//     final lsdishes = await db.getAllDishes();
//     setState(() => listDishes = lsdishes);
//   }

//   /* ------------------------------------------------------------------ */
//   /*                         SHIFT UTILITIES                            */
//   /* ------------------------------------------------------------------ */
//   TimeOfDay _parse(String hhmm) {
//     final p = hhmm.split(':');
//     return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
//   }

//   bool _inRange(TimeOfDay s, TimeOfDay e, TimeOfDay n) {
//     final ss = s.hour * 60 + s.minute;
//     final ee = e.hour * 60 + e.minute;
//     final nn = n.hour * 60 + n.minute;
//     return ee < ss ? (nn >= ss || nn <= ee) : (nn >= ss && nn <= ee);
//   }

//   // int? _currentShiftId() {
//   //   final now = TimeOfDay.now();
//   //   for (final s in shifts) {
//   //     if (_inRange(_parse(s['start_time']), _parse(s['end_time']), now)) {
//   //       return s['id'] as int;
//   //     }
//   //   }
//   //   return null;
//   // }

//   /* ------------------------------------------------------------------ */
//   /*                         FILTER TABLES                              */
//   /* ------------------------------------------------------------------ */
//   void _filterTables() async {
//     if (selectedAreaId == null) {
//       filteredTables = [];
//       return;
//     }

//     // Get tables for the chosen area
//     final areaTables = await db.getTablesByArea(selectedAreaId!);

//     // Convert each TableModel to Map<String, dynamic>
//     filteredTables = areaTables.map((t) => t.toMap()).toList();
//   }

//   /* ------------------------------------------------------------------ */
//   /*                        UI CALLBACKS                                */
//   /* ------------------------------------------------------------------ */
//   void onSelectArea(int? id) async {
//     final areaName = await db.getAreaNameById(id!);
//     setState(() {
//       selectedAreaId = id;
//       selectedAreaName = areaName;
//       selectedTableId = null;
//       _filterTables();
//     });
//   }

//   void onSelectTable(int? id) => setState(() => selectedTableId = id);

//   /* ------------------------------------------------------------------ */
//   /*                          BUILD UI                                  */
//   /* ------------------------------------------------------------------ */
//   @override
//   Widget build(BuildContext context) {
//     final isCustomer = widget.role == "Khách";
//     final isManage = widget.role == 'Quản lý';

//     return Scaffold(
//       appBar: AppBar(title: const Text('Tạo đơn hàng mới')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           /* ---------- CHỌN KHU VỰC & BÀN ---------- */
//           if (!isStaff) ...[
//             /* -- Khách / quản lý: tùy chọn đầy đủ -- */
//             _areaDropdown(_listAreas.map((a) => a.id as int).toList()),
//             const SizedBox(height: 10),
//             _tableDropdown(),
//             const SizedBox(height: 10),
//             _timePickerRow(), // khách chọn giờ
//             const Divider(),
//           ] else ...[
//             /* -- Nhân viên: chỉ khu vực/bàn trong ca -- */
//             // _areaDropdown(staffAreas.toList()),
//             _areaDropdown(
//               isStaff
//                   ? staffAreas.toList()
//                   : _listAreas.map((a) => a.id!).toList(),
//             ),

//             const SizedBox(height: 10),
//             _tableDropdown(),
//             TextField(
//               controller: _customerNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Họ tên khách',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _customerPhoneController,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: 'Số điện thoại khách',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Divider(),
//           ],

//           /* ---------- GHI CHÚ ---------- */
//           TextField(
//             controller: _noteController,
//             decoration: const InputDecoration(
//               labelText: 'Ghi chú đơn hàng',
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 2,
//           ),

//           const SizedBox(height: 20),

//           /* ---------- CHỌN MÓN ---------- */
//           const Text('Chọn món', style: TextStyle(fontWeight: FontWeight.bold)),

//           ...listDishes.map(_dishTile),

//           // ElevatedButton(
//           //   onPressed: () async {
//           //     // Chuyển đến MenuScreen và chờ trả về danh sách món đã chọn
//           //     final selectedDishes = await Navigator.push(
//           //       context,
//           //       MaterialPageRoute(builder: (_) => MenuScreen(role: widget.role,)),
//           //     );
//           //     if (selectedDishes != null) {
//           //       setState(() {
//           //         // Lưu món đã chọn để hiển thị ở AddOrderScreen (nếu cần)
//           //         this.selectedDishes = selectedDishes;
//           //       });
//           //     }
//           //   },
//           //   child: Text("Chọn món"),
//           // ),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: _submitOrder,
//             //_canSubmit ? _submitOrder : null,
//             icon: const Icon(Icons.check),
//             label: const Text('Xác nhận tạo đơn'),
//           ),
//         ],
//       ),
//     );
//   }

//   /* ---------------------- WIDGET HELPERS ------------------------------------- */

//   Widget _areaDropdown(List<int> areaIds) {
//     return DropdownButtonFormField<int>(
//       decoration: const InputDecoration(labelText: 'Khu vực'),
//       value: selectedAreaId,
//       items:
//           areaIds.map((id) {
//             final area = _listAreas.firstWhere((a) => a.id == id);
//             return DropdownMenuItem(value: id, child: Text(area.name));
//           }).toList(),
//       onChanged: onSelectArea,
//       disabledHint: Text(
//         isStaff
//             ? (areaIds.isEmpty
//                 ? 'Không có ca hôm nay'
//                 : _listAreas.firstWhere((a) => a.id == areaIds.first).name)
//             : 'Chọn khu vực',
//       ),
//     );
//   }

//   Widget _tableDropdown() {
//     final isDropdownDisabled = selectedAreaId == null || filteredTables.isEmpty;

//     return DropdownButtonFormField<int>(
//       decoration: const InputDecoration(labelText: 'Chọn bàn'),
//       value: selectedTableId,
//       items:
//           isDropdownDisabled
//               ? null
//               : filteredTables
//                   .map(
//                     (t) => DropdownMenuItem<int>(
//                       value: t['id'] as int,
//                       child: Text(
//                         'Bàn ${t['id']} • ${t['seat_count']} chỗ • ${t['status']}',
//                       ),
//                     ),
//                   )
//                   .toList(),
//       onChanged: isDropdownDisabled ? null : onSelectTable,
//       disabledHint: Text(
//         selectedAreaId == null
//             ? (isStaff
//                 ? 'Chọn khu vực (trong ca)'
//                 : 'Vui lòng chọn khu vực trước')
//             : 'Chưa có bàn trống ở khu vực này',
//       ),
//     );
//   }

//   Widget _timePickerRow() => Row(
//     children: [
//       Text(
//         _selectedTime == null
//             ? 'Chọn giờ'
//             : 'Giờ đã chọn: ${_selectedTime!.format(context)}',
//       ),
//       const Spacer(),
//       TextButton(onPressed: _pickTime, child: const Text('Chọn giờ')),
//     ],
//   );

//   Widget _dishTile(Dish d) {
//     final name = d.name;
//     final price = d.price.toString();
//     final qty = _selectedDishes[name] ?? 0;

//     return ListTile(
//       title: Text(name),
//       subtitle: Text('Giá: $price đ'),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.remove),
//             onPressed:
//                 qty > 0
//                     ? () => setState(() => _selectedDishes[name] = qty - 1)
//                     : null,
//           ),
//           Text('$qty'),
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => setState(() => _selectedDishes[name] = qty + 1),
//           ),
//         ],
//       ),
//     );
//   }

//   bool get _canSubmit {
//     return selectedTableId != null && _selectedDishes.values.any((q) => q > 0);
//   }

//   // bool get _canSubmit {
//   //   return selectedAreaId != null &&
//   //       selectedTableId != null &&
//   //       _selectedDishes.isNotEmpty;
//   // }

//   // void _submitOrder() async {
//   //   final now = DateTime.now();

//   //   // final total = _selectedDishes.entries.fold<int>(0, (s, e) {
//   //   //   final price = int.parse(
//   //   //     listDishes.firstWhere((d) => d['name'] == e.key)['price'],
//   //   //   );
//   //   //   return s + price * e.value;
//   //   // });
//   //   // final total = _selectedDishes.entries.fold<double>(0.0, (sum, entry) {
//   //   //   final dish = listDishes.firstWhere((d) => d.name == entry.key);
//   //   //   return sum + dish.price * entry.value;
//   //   // });
//   //   final total = _selectedDishes.entries.fold<double>(0.0, (sum, entry) {
//   //     final dish = listDishes.firstWhere(
//   //       (d) => d.name == entry.key,
//   //       orElse: () => throw Exception('Không tìm thấy món: ${entry.key}'),
//   //     );
//   //     return sum + dish.price * entry.value;
//   //   });

//   //   final order = Order(
//   //     id: 0, // Sẽ được auto-gen bởi DB, bỏ qua khi insert
//   //     customer_id: null,
//   //     customerName:
//   //         isStaff
//   //             ? _customerNameController.text.trim()
//   //             : (widget.role == 'Khách' ? widget.name : ''),
//   //     staffId:
//   //         isStaff
//   //             ? widget.id
//   //             : null, // Giả sử staffId là 1, bạn thay bằng thực tế
//   //     staffName: isStaff ? widget.name : '',
//   //     table_id: selectedTableId!,
//   //     areaName: selectedAreaName!,
//   //     status: 'Chờ xử lý',
//   //     totalAmount: total.round(),
//   //     note: _noteController.text.trim(),
//   //     createdAt: now,
//   //     updatedAt: now,
//   //   );

//   //   final orderDetails =
//   //       _selectedDishes.entries.where((e) => e.value > 0).map((e) {
//   //         final dishId = dishes.firstWhere((d) => d['name'] == e.key)['id'];
//   //         return OrderDetail(
//   //           orderId: null, // sẽ set sau khi có orderId
//   //           dishId: dishId,
//   //           quantity: e.value,
//   //           status: 'Chờ xử lý',
//   //           chefId: null,
//   //           createdAt: now.toIso8601String(),
//   //           updatedAt: now.toIso8601String(),
//   //         );
//   //       }).toList();

//   //   try {
//   //     final orderId = await db.insertOrder(order);

//   //     for (var detail in orderDetails) {
//   //       detail.orderId = orderId;
//   //     }

//   //     await db.insertOrderDetails(orderDetails);

//   //     ScaffoldMessenger.of(
//   //       context,
//   //     ).showSnackBar(SnackBar(content: Text('Đặt món thành công!')));

//   //     Navigator.pop(context); // hoặc truyền lại order nếu cần
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(
//   //       context,
//   //     ).showSnackBar(SnackBar(content: Text('Lỗi đặt món: $e')));
//   //   }
//   // }

//   void _submitOrder() async {
//     final now = DateTime.now();

//     try {
//       // 1. Xử lý khách hàng (nếu là nhân viên đặt)
//       int? customerId;
//       if (isStaff && _customerNameController.text.trim().isNotEmpty) {
//         final customerName = _customerNameController.text.trim();
//         final customerPhone = _customerPhoneController.text.trim();

//         // Tìm xem khách hàng đã tồn tại trong DB chưa
//         final existingUser = await db.findUserBySDT(customerPhone);

//         if (existingUser != null) {
//           customerId = existingUser.id;
//         } else {
//           // Nếu chưa tồn tại, thêm mới vào bảng Users
//           final newUser = User(
//             username: '',
//             password: '',
//             fullname: customerName,
//             role: 'Khách',
//             phone: customerPhone,
//             email: '',
//             address: '',
//             createdAt: now.toIso8601String(),
//           );
//           customerId = await db.insertUser(newUser);
//         }
//       }

//       // 2. Tính tổng tiền đơn hàng (giá * số lượng)

//       final total = _selectedDishes.entries.fold<double>(0.0, (s, e) {
//         final matched = listDishes.where((d) => d.name == e.key).toList();
//         if (matched.isEmpty) return s;

//         final dish = matched.first;
//         print('Check dish khi sử dụng: listDishes $dish');
//         // print('Hiển thị thông tin dish món chọn $dish');
//         return s + dish.price * e.value;
//       });

//       print('Tổng tiền: $total');
//       // 3. Tạo đơn hàng (Order)
//       // final order = Order(
//       //   id: 0, // sẽ được auto tăng
//       //   customer_id: customerId,
//       //   customerName: '',
//       //   staffId: isStaff ? widget.id : null,
//       //   staffName: isStaff ? widget.name : '',
//       //   table_id: selectedTableId!,
//       //   areaName: selectedAreaName!,
//       //   status: 'Chờ xử lý',
//       //   totalAmount: total.round(),
//       //   note: _noteController.text.trim(),
//       //   createdAt: now,
//       //   updatedAt: now,
//       // );

//       // // 4. Chi tiết đơn hàng (OrderDetail)
//       // print('Check add order bên addorderscreen: $order');
//       // final orderDetails =
//       //     _selectedDishes.entries
//       //         .where((e) => e.value > 0)
//       //         .map((e) {
//       //           final matched =
//       //               listDishes.where((d) => d.name == e.key).toList();
//       //           if (matched.isEmpty) {
//       //             print('Không tìm thấy món: ${e.key}');
//       //             return null;
//       //           }
//       //           final dish = matched.first;
//       //           print('Dữ liệu trong bảng order detail');
//       //           print('Món đặt: ${e.key}');
//       //           print('Dish id: ${dish.id}');
//       //           return OrderDetail(
//       //             orderId: null,
//       //             dishId: dish.id,
//       //             quantity: e.value,
//       //             status: 'Chờ xử lý',
//       //             chefId: null,
//       //             createdAt: now.toIso8601String(),
//       //             updatedAt: now.toIso8601String(),
//       //           );
//       //         })
//       //         .whereType<OrderDetail>()
//       //         .toList();
//       // print('Check orderDetails ở add order screen: $orderDetails');
//       // // 5. Lưu vào DB
//       // final orderId = await db.insertOrder(order);
//       // for (var detail in orderDetails) {
//       //   detail.orderId = orderId;
//       // }
//       // await db.insertOrderDetails(orderDetails);

//       //test
//       // 3. Tạo đơn hàng (Order)
//       final order = Order(
//         id: 0, // auto-increment
//         customer_id: customerId,
//         customerName: '',
//         staffId: isStaff ? widget.id : null,
//         staffName: isStaff ? widget.name : '',
//         table_id: selectedTableId!,
//         areaName: selectedAreaName!,
//         status: 'Chờ xử lý',
//         totalAmount: total.round(),
//         note: _noteController.text.trim(),
//         createdAt: now,
//         updatedAt: now,
//       );

//       print('🔹 Order chuẩn bị thêm vào DB:');
//       print(' - customerId: ${order.customer_id}');
//       print(' - staffId: ${order.staffId}');
//       print(' - table_id: ${order.table_id}');
//       print(' - totalAmount: ${order.totalAmount}');
//       print(' - note: ${order.note}');

//       // 4. Tạo danh sách chi tiết đơn hàng
//       final orderDetails =
//           _selectedDishes.entries
//               .where((e) => e.value > 0)
//               .map((e) {
//                 final matched =
//                     listDishes.where((d) => d.name == e.key).toList();
//                 if (matched.isEmpty) {
//                   print('❌ Không tìm thấy món: ${e.key}');
//                   return null;
//                 }
//                 final dish = matched.first;

//                 print('🟩 Món đặt: ${dish.name}');
//                 print(' - Dish ID: ${dish.id}');
//                 print(' - Số lượng: ${e.value}');

//                 return OrderDetail(
//                   orderId: null,
//                   dishId: dish.id,
//                   quantity: e.value,
//                   status: 'Chờ xử lý',
//                   chefId: null,
//                   createdAt: now.toIso8601String(),
//                   updatedAt: now.toIso8601String(),
//                 );
//               })
//               .whereType<OrderDetail>()
//               .toList();

//       print('🔹 Tổng số món trong OrderDetail: ${orderDetails.length}');
//       for (var detail in orderDetails) {
//         print(' - dishId: ${detail.dishId}, quantity: ${detail.quantity}');
//       }

//       // 5. Lưu vào DB
//       final orderId = await db.insertOrder(order);
//       print('✅ Order đã được lưu với ID: $orderId');

//       for (var detail in orderDetails) {
//         detail.orderId = orderId;
//       }

//       await db.insertOrderDetails(orderDetails);
//       print('✅ OrderDetails đã được lưu xong.');
//       print('👉 Insert từng OrderDetail:');
//       for (var d in orderDetails) {
//         print('map${d.toMap()}'); // Hoặc in từng field rõ ràng hơn
//       }

//       final savedDetails = await db.getOrderDetailsByOrderId(orderId);
//       print('🔎 Kiểm tra OrderDetails đã lưu cho orderId = $orderId:');
//       for (var d in savedDetails) {
//         print(
//           ' - dish_name: ${d['dish_name']}, quantity: ${d['quantity']}, status: ${d['status']}, chef_name: ${d['chef_name']}',
//         );
//       }

//       // 6. Thông báo thành công
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Đặt món thành công!')));
//       // Navigator.pop(context, orderId);
//       Navigator.pop(context, orderId);
//     } catch (e) {
//       // Báo lỗi
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Lỗi đặt món: $e')));
//     }
//   }

//   /* -------------------------------------------------------------------------- */
//   Future<void> _pickTime() async {
//     final t = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (t != null) setState(() => _selectedTime = t);
//   }

//   @override
//   void dispose() {
//     _noteController.dispose();
//     _customerNameController.dispose();
//     _customerPhoneController.dispose();
//     super.dispose();
//   }
// }

//test chọn món bên menu
//test db
import 'package:dt02_nhom09/class/area.dart';
import 'package:dt02_nhom09/class/listFood.dart';
import 'package:dt02_nhom09/class/order_detail.dart';
import 'package:dt02_nhom09/class/order_model.dart';
import 'package:dt02_nhom09/class/table_model.dart';
import 'package:dt02_nhom09/class/user.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:dt02_nhom09/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// import '../data/mock_data.dart';
import 'package:dt02_nhom09/screens/order_mode.dart';

class AddOrderScreen extends StatefulWidget {
  final OrderMode mode;
  final int id;
  final String name;
  final String role;

  const AddOrderScreen({
    super.key,
    required this.mode,
    required this.id,
    required this.name,
    required this.role,
  });

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  /* ---------- controller & state chung ---------- */
  final _noteController = TextEditingController();
  int? selectedAreaId;
  int? selectedTableId;
  TimeOfDay? _selectedTime; // chỉ dùng cho khách / quản lý
  // final Map<String, int> _selectedDishes = {};
  List<Dish> _selectedDishes = []; // dishName -> qty
  List<Map<String, dynamic>> filteredTables = [];
  //thông tin khách
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  /* ---------- flag & dữ liệu riêng cho staff ---------- */
  late final bool isStaff;
  late final bool isManage;
  int? staffId;
  // List<Map<String, dynamic>> staffTables = [];
  Set<int> staffTables = {};
  Set<int> staffAreas = {};

  List<Area> _listAreas = [];
  //table by areaId
  List<TableModel> _listTables = [];
  DatabaseHelper db = DatabaseHelper();

  List<Dish> listDishes = [];

  /* ------------------------------------------------------------------ */
  /*                              INIT                                  */
  /* ------------------------------------------------------------------ */
  @override
  void initState() {
    super.initState();
    print('Check id: ${widget.id}, Name:${widget.name}, role: ${widget.role}');
    isStaff = widget.role == 'Nhân viên';
    isManage = widget.role == 'Quản lý';
    _loadAreas();
    _loadDishes();
    // printStaffShifts();
    // _loadShiftData();
    if (isStaff) {
      // _loadShiftData();
      checkStaffSchedule(widget.id);
    }

    if (isStaff && selectedAreaId != null) _filterTables();
  }

  List<String> areaList = [];

  String getShiftName(String start, String end) {
    if (start == '08:00' && end == '13:00') return 'Ca sáng';
    if (start == '13:00' && end == '18:00') return 'Ca chiều';
    if (start == '18:00' && end == '23:00') return 'Ca tối';
    return 'Ca khác';
  }

  void checkStaffSchedule(int staffId) async {
    final data = await db.getTodayScheduleAndArea(staffId);

    if (data != null) {
      print('Ca: ${getShiftName(data['start_time'], data['end_time'])}');
      print('Giờ bắt đầu: ${data['start_time']}');
      print('Giờ kết thúc: ${data['end_time']}');
      print('Ngày đăng ký: ${data['created_at']}');
      print('Khu vực: ${data['area_name']}');

      int areaId = data['area_id'];
      int tableId = data['table_id'];
      print('Check areaId trong hàm checkStaffSchedule: $areaId');
      Area? area = await db.getAreaById(areaId);
      print('Check areaId trong hàm checkStaffSchedule: $area');
      if (area != null) {
        setState(() {
          _listAreas = [area];
          staffAreas = {area.id!};
          if (staffAreas.length == 1) selectedAreaId = staffAreas.first;
        });
      } else {
        _listAreas = [];
        staffAreas = {};
      }

      // Lấy bàn theo id
      TableModel? table = await db.getTableById(tableId);

      if (table != null) {
        _listTables = [table];
        staffTables = {table.id!};
        if (staffTables.length == 1) selectedTableId = staffTables.first;
      } else {
        _listTables = [];
        staffTables = {};
      }

      print('Bàn số: ${table?.id ?? 'Không có'}');
    } else {
      print('Hôm nay bạn không có ca làm hoặc không trong thời gian ca.');
    }
  }

  String? selectedAreaName;

  //đăng ký nhiều lịch
  // void checkStaffSchedule(int staffId) async {
  //   final dataList = await db.getTodayScheduleAndArea(staffId);

  //   if (dataList != null && dataList.isNotEmpty) {
  //     // Ví dụ xử lý ca làm đầu tiên (hoặc bạn có thể xử lý tất cả)
  //     for (var data in dataList) {
  //       print('Ca: ${getShiftName(data['start_time'], data['end_time'])}');
  //       print('Giờ bắt đầu: ${data['start_time']}');
  //       print('Giờ kết thúc: ${data['end_time']}');
  //       print('Ngày đăng ký: ${data['created_at']}');
  //       print('Khu vực: ${data['area_name']}');

  //       int areaId = data['area_id'];
  //       int tableId = data['table_id'];

  //       Area? area = await db.getAreaById(areaId);
  //       if (area != null) {
  //         _listAreas = [area];
  //         staffAreas = {area.id!};
  //         if (staffAreas.length == 1) selectedAreaId = staffAreas.first;
  //       } else {
  //         _listAreas = [];
  //         staffAreas = {};
  //       }

  //       // Lấy bàn theo id
  //       TableModel? table = await db.getTableById(tableId);

  //       if (table != null) {
  //         _listTables = [table];
  //         staffTables = {table.id!};
  //         if (staffTables.length == 1) selectedTableId = staffTables.first;
  //       } else {
  //         _listTables = [];
  //         staffTables = {};
  //       }

  //       print('Bàn số: ${table?.id ?? 'Không có'}');

  //       print('--------------------'); // Dòng phân cách giữa các ca
  //     }
  //   } else {
  //     print('Hôm nay bạn không có ca làm hoặc không trong thời gian ca.');
  //   }
  // }

  // void printStaffShifts() async {
  //   final shifts = await DatabaseHelper().getShiftsOfStaff(3);
  //   for (var shift in shifts) {
  //     print('Ca: ${shift['shiftname']}');
  //     print('Giờ bắt đầu: ${shift['start_time']}');
  //     print('Giờ kết thúc: ${shift['end_time']}');
  //     print('Ngày đăng ký: ${shift['created_at']}');
  //     print('---');
  //   }
  // }

  //show all areas
  Future<void> _loadAreas() async {
    // ← thêm hàm
    final lsarea = await db.getAllAreas();
    setState(() => _listAreas = lsarea);
  }

  Future<void> _loadDishes() async {
    final lsdishes = await db.getAllDishes();
    setState(() => listDishes = lsdishes);
  }

  /* ------------------------------------------------------------------ */
  /*                         SHIFT UTILITIES                            */
  /* ------------------------------------------------------------------ */
  TimeOfDay _parse(String hhmm) {
    final p = hhmm.split(':');
    return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
  }

  bool _inRange(TimeOfDay s, TimeOfDay e, TimeOfDay n) {
    final ss = s.hour * 60 + s.minute;
    final ee = e.hour * 60 + e.minute;
    final nn = n.hour * 60 + n.minute;
    return ee < ss ? (nn >= ss || nn <= ee) : (nn >= ss && nn <= ee);
  }

  // int? _currentShiftId() {
  //   final now = TimeOfDay.now();
  //   for (final s in shifts) {
  //     if (_inRange(_parse(s['start_time']), _parse(s['end_time']), now)) {
  //       return s['id'] as int;
  //     }
  //   }
  //   return null;
  // }

  /* ------------------------------------------------------------------ */
  /*                         FILTER TABLES                              */
  /* ------------------------------------------------------------------ */
  void _filterTables() async {
    if (selectedAreaId == null) {
      filteredTables = [];
      return;
    }

    // Get tables for the chosen area
    final areaTables = await db.getTablesByArea(selectedAreaId!);

    // Convert each TableModel to Map<String, dynamic>
    filteredTables = areaTables.map((t) => t.toMap()).toList();
  }

  /* ------------------------------------------------------------------ */
  /*                        UI CALLBACKS                                */
  /* ------------------------------------------------------------------ */
  void onSelectArea(int? id) async {
    final areaName = await db.getAreaNameById(id!);
    setState(() {
      selectedAreaId = id;
      selectedAreaName = areaName;
      selectedTableId = null;
      _filterTables();
    });
  }

  void onSelectTable(int? id) => setState(() => selectedTableId = id);

  /* ------------------------------------------------------------------ */
  /*                          BUILD UI                                  */
  /* ------------------------------------------------------------------ */
  @override
  Widget build(BuildContext context) {
    final isCustomer = widget.role == "Khách";
    final isManage = widget.role == 'Quản lý';

    return Scaffold(
      appBar: AppBar(title: const Text('Tạo đơn hàng mới')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /* ---------- CHỌN KHU VỰC & BÀN ---------- */
          if (!isStaff) ...[
            /* -- Khách / quản lý: tùy chọn đầy đủ -- */
            _areaDropdown(_listAreas.map((a) => a.id as int).toList()),
            const SizedBox(height: 10),
            _tableDropdown(),
            const SizedBox(height: 10),
            _timePickerRow(), // khách chọn giờ
            const Divider(),
          ] else ...[
            /* -- Nhân viên: chỉ khu vực/bàn trong ca -- */
            // _areaDropdown(staffAreas.toList()),
            _areaDropdown(
              isStaff
                  ? staffAreas.toList()
                  : _listAreas.map((a) => a.id!).toList(),
            ),

            const SizedBox(height: 10),
            _tableDropdown(),
            TextField(
              controller: _customerNameController,
              decoration: const InputDecoration(
                labelText: 'Họ tên khách',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _customerPhoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Số điện thoại khách',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
          ],

          /* ---------- GHI CHÚ ---------- */
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              labelText: 'Ghi chú đơn hàng',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),

          const SizedBox(height: 20),

          /* ---------- CHỌN MÓN ---------- */
          const Text('Chọn món', style: TextStyle(fontWeight: FontWeight.bold)),

          // ...listDishes.map(_dishTile),
          ElevatedButton(
            onPressed: () async {
              // Chuyển đến MenuScreen và chờ trả về danh sách món đã chọn
              final selectedDishes = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MenuScreen(role: widget.role),
                ),
              );
              if (selectedDishes != null) {
                setState(() {
                  // Lưu món đã chọn để hiển thị ở AddOrderScreen (nếu cần)
                  _selectedDishes = selectedDishes;
                });
              }
            },
            child: Text("Chọn món"),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _submitOrder,
            //_canSubmit ? _submitOrder : null,
            icon: const Icon(Icons.check),
            label: const Text('Xác nhận tạo đơn'),
          ),
        ],
      ),
    );
  }

  /* ---------------------- WIDGET HELPERS ------------------------------------- */

  Widget _areaDropdown(List<int> areaIds) {
    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(labelText: 'Khu vực'),
      value: selectedAreaId,
      items:
          areaIds.map((id) {
            final area = _listAreas.firstWhere((a) => a.id == id);
            return DropdownMenuItem(value: id, child: Text(area.name));
          }).toList(),
      onChanged: onSelectArea,
      disabledHint: Text(
        isStaff
            ? (areaIds.isEmpty
                ? 'Không có ca hôm nay'
                : _listAreas.firstWhere((a) => a.id == areaIds.first).name)
            : 'Chọn khu vực',
      ),
    );
  }

  Widget _tableDropdown() {
    final isDropdownDisabled = selectedAreaId == null || filteredTables.isEmpty;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(labelText: 'Chọn bàn'),
      value: selectedTableId,
      items:
          isDropdownDisabled
              ? null
              : filteredTables
                  .map(
                    (t) => DropdownMenuItem<int>(
                      value: t['id'] as int,
                      child: Text(
                        'Bàn ${t['id']} • ${t['seat_count']} chỗ • ${t['status']}',
                      ),
                    ),
                  )
                  .toList(),
      onChanged: isDropdownDisabled ? null : onSelectTable,
      disabledHint: Text(
        selectedAreaId == null
            ? (isStaff
                ? 'Chọn khu vực (trong ca)'
                : 'Vui lòng chọn khu vực trước')
            : 'Chưa có bàn trống ở khu vực này',
      ),
    );
  }

  Widget _timePickerRow() => Row(
    children: [
      Text(
        _selectedTime == null
            ? 'Chọn giờ'
            : 'Giờ đã chọn: ${_selectedTime!.format(context)}',
      ),
      const Spacer(),
      TextButton(onPressed: _pickTime, child: const Text('Chọn giờ')),
    ],
  );

  Widget _dishTile(Dish d) {
    final name = d.name;
    final price = d.price.toString();
    final qty = d.quantity;

    return ListTile(
      title: Text(name),
      subtitle: Text('Giá: $price đ'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed:
                qty > 0 ? () => setState(() => d.quantity = qty - 1) : null,
          ),
          Text('$qty'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => d.quantity = qty + 1),
          ),
        ],
      ),
    );
  }

  bool get _canSubmit {
    return selectedTableId != null &&
        _selectedDishes.any((dish) => dish.quantity > 0);
  }

  // bool get _canSubmit {
  //   return selectedAreaId != null &&
  //       selectedTableId != null &&
  //       _selectedDishes.isNotEmpty;
  // }

  // void _submitOrder() async {
  //   final now = DateTime.now();

  //   // final total = _selectedDishes.entries.fold<int>(0, (s, e) {
  //   //   final price = int.parse(
  //   //     listDishes.firstWhere((d) => d['name'] == e.key)['price'],
  //   //   );
  //   //   return s + price * e.value;
  //   // });
  //   // final total = _selectedDishes.entries.fold<double>(0.0, (sum, entry) {
  //   //   final dish = listDishes.firstWhere((d) => d.name == entry.key);
  //   //   return sum + dish.price * entry.value;
  //   // });
  //   final total = _selectedDishes.entries.fold<double>(0.0, (sum, entry) {
  //     final dish = listDishes.firstWhere(
  //       (d) => d.name == entry.key,
  //       orElse: () => throw Exception('Không tìm thấy món: ${entry.key}'),
  //     );
  //     return sum + dish.price * entry.value;
  //   });

  //   final order = Order(
  //     id: 0, // Sẽ được auto-gen bởi DB, bỏ qua khi insert
  //     customer_id: null,
  //     customerName:
  //         isStaff
  //             ? _customerNameController.text.trim()
  //             : (widget.role == 'Khách' ? widget.name : ''),
  //     staffId:
  //         isStaff
  //             ? widget.id
  //             : null, // Giả sử staffId là 1, bạn thay bằng thực tế
  //     staffName: isStaff ? widget.name : '',
  //     table_id: selectedTableId!,
  //     areaName: selectedAreaName!,
  //     status: 'Chờ xử lý',
  //     totalAmount: total.round(),
  //     note: _noteController.text.trim(),
  //     createdAt: now,
  //     updatedAt: now,
  //   );

  //   final orderDetails =
  //       _selectedDishes.entries.where((e) => e.value > 0).map((e) {
  //         final dishId = dishes.firstWhere((d) => d['name'] == e.key)['id'];
  //         return OrderDetail(
  //           orderId: null, // sẽ set sau khi có orderId
  //           dishId: dishId,
  //           quantity: e.value,
  //           status: 'Chờ xử lý',
  //           chefId: null,
  //           createdAt: now.toIso8601String(),
  //           updatedAt: now.toIso8601String(),
  //         );
  //       }).toList();

  //   try {
  //     final orderId = await db.insertOrder(order);

  //     for (var detail in orderDetails) {
  //       detail.orderId = orderId;
  //     }

  //     await db.insertOrderDetails(orderDetails);

  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Đặt món thành công!')));

  //     Navigator.pop(context); // hoặc truyền lại order nếu cần
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Lỗi đặt món: $e')));
  //   }
  // }

  void _submitOrder() async {
    final now = DateTime.now();

    try {
      // 1. Xử lý khách hàng (nếu là nhân viên đặt)
      int? customerId;
      if (isStaff && _customerNameController.text.trim().isNotEmpty) {
        final customerName = _customerNameController.text.trim();
        final customerPhone = _customerPhoneController.text.trim();

        // Tìm xem khách hàng đã tồn tại trong DB chưa
        final existingUser = await db.findUserBySDT(customerPhone);

        if (existingUser != null) {
          customerId = existingUser.id;
        } else {
          // Nếu chưa tồn tại, thêm mới vào bảng Users
          final newUser = User(
            username: '',
            password: '',
            fullname: customerName,
            role: 'Khách',
            phone: customerPhone,
            email: '',
            address: '',
            createdAt: now.toIso8601String(),
          );
          customerId = await db.insertUser(newUser);
        }
      }

      // 2. Tính tổng tiền đơn hàng (giá * số lượng)

      final total = _selectedDishes.fold<double>(
        0.0,
        (sum, dish) => sum + dish.price * dish.quantity,
      );

      print('Tổng tiền: $total');
      // 3. Tạo đơn hàng (Order)
      // final order = Order(
      //   id: 0, // sẽ được auto tăng
      //   customer_id: customerId,
      //   customerName: '',
      //   staffId: isStaff ? widget.id : null,
      //   staffName: isStaff ? widget.name : '',
      //   table_id: selectedTableId!,
      //   areaName: selectedAreaName!,
      //   status: 'Chờ xử lý',
      //   totalAmount: total.round(),
      //   note: _noteController.text.trim(),
      //   createdAt: now,
      //   updatedAt: now,
      // );

      // // 4. Chi tiết đơn hàng (OrderDetail)
      // print('Check add order bên addorderscreen: $order');
      // final orderDetails =
      //     _selectedDishes.entries
      //         .where((e) => e.value > 0)
      //         .map((e) {
      //           final matched =
      //               listDishes.where((d) => d.name == e.key).toList();
      //           if (matched.isEmpty) {
      //             print('Không tìm thấy món: ${e.key}');
      //             return null;
      //           }
      //           final dish = matched.first;
      //           print('Dữ liệu trong bảng order detail');
      //           print('Món đặt: ${e.key}');
      //           print('Dish id: ${dish.id}');
      //           return OrderDetail(
      //             orderId: null,
      //             dishId: dish.id,
      //             quantity: e.value,
      //             status: 'Chờ xử lý',
      //             chefId: null,
      //             createdAt: now.toIso8601String(),
      //             updatedAt: now.toIso8601String(),
      //           );
      //         })
      //         .whereType<OrderDetail>()
      //         .toList();
      // print('Check orderDetails ở add order screen: $orderDetails');
      // // 5. Lưu vào DB
      // final orderId = await db.insertOrder(order);
      // for (var detail in orderDetails) {
      //   detail.orderId = orderId;
      // }
      // await db.insertOrderDetails(orderDetails);

      //test
      // 3. Tạo đơn hàng (Order)
      final order = Order(
        id: 0, // auto-increment
        customer_id: customerId,
        customerName: '',
        staffId: isStaff ? widget.id : null,
        staffName: isStaff ? widget.name : '',
        table_id: selectedTableId!,
        areaName: selectedAreaName!,
        status: 'Chờ xử lý',
        totalAmount: total.round(),
        note: _noteController.text.trim(),
        createdAt: now,
        updatedAt: now,
      );

      print('🔹 Order chuẩn bị thêm vào DB:');
      print(' - customerId: ${order.customer_id}');
      print(' - staffId: ${order.staffId}');
      print(' - table_id: ${order.table_id}');
      print(' - totalAmount: ${order.totalAmount}');
      print(' - note: ${order.note}');

      // 4. Tạo danh sách chi tiết đơn hàng
      final orderDetails =
          _selectedDishes.where((d) => d.quantity > 0).map((dish) {
            return OrderDetail(
              orderId: null,
              dishId: dish.id,
              quantity: dish.quantity,
              status: 'Chờ xử lý',
              chefId: null,
              createdAt: now.toIso8601String(),
              updatedAt: now.toIso8601String(),
            );
          }).toList();

      print('🔹 Tổng số món trong OrderDetail: ${orderDetails.length}');
      for (var detail in orderDetails) {
        print(' - dishId: ${detail.dishId}, quantity: ${detail.quantity}');
      }

      // 5. Lưu vào DB
      final orderId = await db.insertOrder(order);
      print('✅ Order đã được lưu với ID: $orderId');

      for (var detail in orderDetails) {
        detail.orderId = orderId;
      }

      await db.insertOrderDetails(orderDetails);
      print('✅ OrderDetails đã được lưu xong.');
      print('👉 Insert từng OrderDetail:');
      for (var d in orderDetails) {
        print('map${d.toMap()}'); // Hoặc in từng field rõ ràng hơn
      }

      final savedDetails = await db.getOrderDetailsByOrderId(orderId);
      print('🔎 Kiểm tra OrderDetails đã lưu cho orderId = $orderId:');
      for (var d in savedDetails) {
        print(
          ' - dish_name: ${d['dish_name']}, quantity: ${d['quantity']}, status: ${d['status']}, chef_name: ${d['chef_name']}',
        );
      }

      // 6. Thông báo thành công
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đặt món thành công!')));
      // Navigator.pop(context, orderId);
      Navigator.pop(context, orderId);
    } catch (e) {
      // Báo lỗi
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi đặt món: $e')));
    }
  }

  /* -------------------------------------------------------------------------- */
  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) setState(() => _selectedTime = t);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    super.dispose();
  }
}
