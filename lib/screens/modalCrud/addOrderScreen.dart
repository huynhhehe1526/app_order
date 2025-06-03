// // //téttttttttttt
// import 'package:flutter/material.dart';
// import 'package:dt02_nhom09/screens/data/mock_data.dart';
// import 'package:dt02_nhom09/screens/order_mode.dart';

// class AddOrderScreen extends StatefulWidget {
//   final OrderMode mode;
//   final String name;
//   final String role;

//   const AddOrderScreen({
//     super.key,
//     required this.mode,
//     required this.name,
//     required this.role,
//   });

//   @override
//   State<AddOrderScreen> createState() => _AddOrderScreenState();
// }

// class _AddOrderScreenState extends State<AddOrderScreen> {
//   final _noteController = TextEditingController();
//   // String? _selectedArea;
//   // String? _selectedTable;
//   int? selectedAreaId;
//   int? selectedTableId;
//   TimeOfDay? _selectedTime;

//   final Map<String, int> _selectedDishes = {}; // dishName -> quantity

//   List<Map<String, dynamic>> filteredTables = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredTables = [];
//     isStaff = widget.role == 'Nhân viên phục vụ';

//     if (isStaff) {
//       // tìm id nhân viên theo fullname
//       staffId = users
//           .firstWhere((u) => u['fullname'] == widget.name, orElse: () => {})['id'];
//       staffTables = (staffId != null) ? tablesForStaffToday(staffId!) : [];
//       staffAreas  = staffTables.map<int>((t) => t['area_id']).toSet();

//       // auto chọn khu vực nếu chỉ 1
//       if (staffAreas.length == 1) selectedAreaId = staffAreas.first;
//     } else {
//       staffId = null;
//       staffTables = [];
//       staffAreas  = {};
//     }
//   }

//   void onSelectArea(int? areaId) {
//     setState(() {
//       selectedAreaId = areaId;
//       selectedTableId = null; // reset bàn khi đổi khu vực
//       if (selectedAreaId != null) {
//         filteredTables =
//             tables
//                 .where(
//                   (table) =>
//                       table['area_id'] == selectedAreaId &&
//                       table['status'] != 'Đã đặt' &&
//                       table['status'] != 'Đang dùng',
//                 )
//                 .toList();
//       } else {
//         filteredTables = [];
//       }
//     });
//   }

//   void onSelectTable(int? tableId) {
//     setState(() {
//       selectedTableId = tableId;
//     });
//   }

//   @override
//   void dispose() {
//     _noteController.dispose();
//     super.dispose();
//   }

//   void _submitOrder() {
//     if (_selectedDishes.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Vui lòng chọn ít nhất 1 món ăn")));
//       return;
//     }

//     // final total = _selectedDishes.entries.fold<double>(0.0, (sum, entry) {
//     //   final dish = dishes.firstWhere((d) => d['name'] == entry.key);
//     //   return sum + (dish['price'] as double) * entry.value;
//     // });
//     final total = _selectedDishes.entries.fold<double>(0.0, (sum, entry) {
//       final dish = dishes.firstWhere((d) => d['name'] == entry.key);
//       final price = double.tryParse(dish['price'].toString()) ?? 0.0;
//       return sum + price * entry.value;
//     });

//     // final orderDetails =
//     //     _selectedDishes.entries.map((entry) {
//     //       final dish = dishes.firstWhere((d) => d['name'] == entry.key);
//     //       return {
//     //         'dish': entry.key,
//     //         'quantity': entry.value,
//     //         'price': dish['price'],
//     //       };
//     //     }).toList();
//     final orderDetails =
//         _selectedDishes.entries.map((entry) {
//           final dish = dishes.firstWhere((d) => d['name'] == entry.key);
//           final price = double.tryParse(dish['price'].toString()) ?? 0.0;
//           return {'dish': entry.key, 'quantity': entry.value, 'price': price};
//         }).toList();

//     final newOrder = {
//       'customer': widget.role == 'Khách hàng' ? widget.name : 'Khách vãng lai',
//       'staff': widget.role == 'Khách hàng' ? null : widget.name,
//       'status': 'Chờ xử lý',
//       'note': _noteController.text,
//       'total': total,
//       'details': orderDetails,
//       if (widget.role == 'Khách hàng') ...{
//         'area': selectedAreaId,
//         'table': selectedTableId,
//         'time': _selectedTime?.format(context),
//       },
//     };

//     Navigator.pop(context, newOrder);
//   }

//   Future<void> _pickTime() async {
//     final time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (time != null) {
//       setState(() {
//         _selectedTime = time;
//       });
//     }
//   }

//   //nếu là role phục vụ
//   /// ---- Chuyển 'HH:mm' thành TimeOfDay
//   TimeOfDay _parseHHMM(String hhmm) {
//     final parts = hhmm.split(':');
//     return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
//   }

//   /// ---- Kiểm tra 'now' nằm trong khoảng start-end (kể cả ca qua nửa đêm)
//   bool _inShift(TimeOfDay start, TimeOfDay end, TimeOfDay now) {
//     final s = start.hour * 60 + start.minute;
//     final e = end.hour * 60 + end.minute;
//     final n = now.hour * 60 + now.minute;
//     return e < s ? (n >= s || n <= e) : (n >= s && n <= e);
//   }

//   /// Trả về shift_id đang diễn ra (hoặc null nếu ngoài khung bất kỳ ca)
//   int? currentShiftId() {
//     final nowTOD = TimeOfDay.now();
//     for (final s in shifts) {
//       if (_inShift(
//         _parseHHMM(s['start_time']),
//         _parseHHMM(s['end_time']),
//         nowTOD,
//       ))
//         return s['id'] as int;
//     }
//     return null;
//   }

//   /// Lấy **bàn** mà nhân viên [staffId] phụ trách
//   /// trong **ca hiện tại** của **ngày hôm nay** (yyyy-MM-dd)
//   List<Map<String, dynamic>> tablesForStaffToday(int staffId) {
//     final today = DateTime.now().toIso8601String().substring(
//       0,
//       10,
//     ); // yyyy-MM-dd
//     final shiftId = currentShiftId();
//     if (shiftId == null) return [];

//     // Lấy các bản ghi phân ca trùng staff + shift + date
//     final tableIds =
//         staffShiftAreas
//             .where(
//               (ssa) =>
//                   ssa['staff_id'] == staffId &&
//                   ssa['shift_id'] == shiftId &&
//                   ssa['date'] == today,
//             )
//             .map<int>((ssa) => ssa['table_id'])
//             .toSet();

//     return tables.where((t) => tableIds.contains(t['id'])).toList();
//   }

//   late final bool isStaff;
//   late final int? staffId;
//   late List<Map<String, dynamic>> staffTables; // bàn theo ca
//   late Set<int> staffAreas; // area_id theo ca

//   @override
//   Widget build(BuildContext context) {
//     final isCustomer = widget.role == 'Khách hàng';
//     final isManage = widget.role == 'Quản lý';
//     return Scaffold(
//       appBar: AppBar(title: Text("Tạo đơn hàng mới")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             if (isCustomer || isManage) ...[
//               DropdownButtonFormField<int>(
//                 decoration: InputDecoration(labelText: 'Chọn khu vực'),
//                 value: selectedAreaId,
//                 items:
//                     areas
//                         .map(
//                           (area) => DropdownMenuItem<int>(
//                             value: area['id'] as int,
//                             child: Text(area['name']),
//                           ),
//                         )
//                         .toList(),
//                 onChanged: onSelectArea,
//               ),
//               SizedBox(height: 10),
//               DropdownButtonFormField<int>(
//                 decoration: InputDecoration(labelText: 'Chọn bàn'),
//                 value: selectedTableId,
//                 items:
//                     filteredTables
//                         .map(
//                           (table) => DropdownMenuItem<int>(
//                             value: table['id'] as int,
//                             child: Text(
//                               'Bàn số ${table['id']} - chỗ ngồi: ${table['seat_count']} - ${table['status']}',
//                             ),
//                           ),
//                         )
//                         .toList(),
//                 onChanged: selectedAreaId == null ? null : onSelectTable,
//                 // disabledHint: Text('Vui lòng chọn khu vực trước'),
//                 disabledHint: Text(
//                   selectedAreaId == null
//                       ? 'Vui lòng chọn khu vực trước'
//                       : 'Chưa có bàn trống ở khu vực này',
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Text(
//                     _selectedTime == null
//                         ? "Chọn giờ"
//                         : "Giờ đã chọn: ${_selectedTime!.format(context)}",
//                   ),
//                   Spacer(),
//                   TextButton(onPressed: _pickTime, child: Text("Chọn giờ")),
//                 ],
//               ),
//               Divider(),
//             ],
//             DropdownButtonFormField<int>(
//               decoration: InputDecoration(labelText: 'Chọn khu vực'),
//               value: selectedAreaId,
//               items:
//                   areas
//                       .map(
//                         (area) => DropdownMenuItem<int>(
//                           value: area['id'] as int,
//                           child: Text(area['name']),
//                         ),
//                       )
//                       .toList(),
//               onChanged: onSelectArea,
//             ),
//             SizedBox(height: 10),
//             DropdownButtonFormField<int>(
//               decoration: InputDecoration(labelText: 'Chọn bàn'),
//               value: selectedTableId,
//               items:
//                   filteredTables
//                       .map(
//                         (table) => DropdownMenuItem<int>(
//                           value: table['id'] as int,
//                           child: Text(
//                             'Bàn số ${table['id']} - chỗ ngồi: ${table['seat_count']} - ${table['status']}',
//                           ),
//                         ),
//                       )
//                       .toList(),
//               onChanged: selectedAreaId == null ? null : onSelectTable,
//               // disabledHint: Text('Vui lòng chọn khu vực trước'),
//               disabledHint: Text(
//                 selectedAreaId == null
//                     ? 'Vui lòng chọn khu vực trước'
//                     : 'Chưa có bàn trống ở khu vực này',
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Text(
//                   _selectedTime == null
//                       ? "Chọn giờ"
//                       : "Giờ đã chọn: ${_selectedTime!.format(context)}",
//                 ),
//                 Spacer(),
//                 TextButton(onPressed: _pickTime, child: Text("Chọn giờ")),
//               ],
//             ),
//             // Ghi chú
//             TextField(
//               controller: _noteController,
//               decoration: InputDecoration(
//                 labelText: "Ghi chú đơn hàng",
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 2,
//             ),

//             SizedBox(height: 20),
//             Text("Chọn món ăn", style: TextStyle(fontWeight: FontWeight.bold)),

//             ...dishes.map((dish) {
//               final name = dish['name'];
//               final price = double.tryParse(dish['price'].toString()) ?? 0.0;
//               final quantity = _selectedDishes[name] ?? 0;

//               return ListTile(
//                 title: Text(name),
//                 subtitle: Text("Giá: ${price.toStringAsFixed(0)}đ"),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.remove),
//                       onPressed:
//                           quantity > 0
//                               ? () => setState(
//                                 () => _selectedDishes[name] = quantity - 1,
//                               )
//                               : null,
//                     ),
//                     Text('$quantity'),
//                     IconButton(
//                       icon: Icon(Icons.add),
//                       onPressed:
//                           () => setState(
//                             () => _selectedDishes[name] = quantity + 1,
//                           ),
//                     ),
//                   ],
//                 ),
//               );
//             }),

//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: _submitOrder,
//               icon: Icon(Icons.check),
//               label: Text("Xác nhận tạo đơn"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //test 11111111111 reeeeeeeeeeeeeeeeeeeee
// //lib/screens/add_order_screen.dart
// import 'package:flutter/material.dart';
// import '../data/mock_data.dart'; // <-- sửa đường dẫn nếu khác
// import 'package:dt02_nhom09/screens/order_mode.dart';

// class AddOrderScreen extends StatefulWidget {
//   final OrderMode mode; // customerOnline | staffWalkIn
//   final String name; // tên người đăng nhập
//   final String role; // 'Nhân viên phục vụ', 'Khách hàng', 'Quản lý', ...

//   const AddOrderScreen({
//     super.key,
//     required this.mode,
//     required this.name,
//     required this.role,
//   });

//   @override
//   State<AddOrderScreen> createState() => _AddOrderScreenState();
// }

// /* -------------------------------------------------------------------------- */
// /*                            _AddOrderScreenState                            */
// /* -------------------------------------------------------------------------- */
// class _AddOrderScreenState extends State<AddOrderScreen> {
//   /* ---------- state chung ---------- */
//   int? _selectedAreaId;
//   int? _selectedTableId;
//   final TextEditingController _note = TextEditingController();
//   final Map<int, int> _dishQty = {}; // dish_id -> qty

//   /* ---------- thông tin nhân viên (nếu có) ---------- */
//   late final bool _isStaff;
//   int? _staffId;
//   late List<Map<String, dynamic>> _staffTables; // bàn theo ca
//   late Set<int> _staffAreaIds; // area_id theo ca

//   /* ------------------------- INIT ------------------------------------------------ */
//   @override
//   void initState() {
//     super.initState();
//     _isStaff = widget.role == 'Nhân viên';

//     if (_isStaff) _prepareStaffShiftData();
//   }

//   /* ----- helper: dựng dữ liệu ca hiện tại của nhân viên ----- */
//   void _prepareStaffShiftData() {
//     /* ◉ bước 1: tìm id nhân viên từ fullname */
//     _staffId =
//         users.firstWhere(
//           (u) => u['fullname'] == widget.name,
//           orElse: () => {},
//         )['id'];

//     /* ◉ bước 2: xác định shift hiện tại */
//     final now = TimeOfDay.now();
//     int? shiftId;
//     for (final s in shifts) {
//       final start = _parseHHMM(s['start_time']);
//       final end = _parseHHMM(s['end_time']);
//       if (_inRange(start, end, now)) {
//         shiftId = s['id'] as int;
//         break;
//       }
//     }

//     /* ◉ bước 3: lọc staffShiftAreas theo staffId + shiftId + hôm nay */
//     final today = DateTime.now().toIso8601String().substring(0, 10);
//     final tableIds =
//         staffShiftAreas
//             .where(
//               (ssa) =>
//                   ssa['staff_id'] == _staffId &&
//                   ssa['shift_id'] == shiftId &&
//                   ssa['date'] == today,
//             )
//             .map<int>((ssa) => ssa['table_id'])
//             .toSet();

//     _staffTables = tables.where((t) => tableIds.contains(t['id'])).toList();
//     _staffAreaIds = _staffTables.map<int>((t) => t['area_id'] as int).toSet();

//     /* ◉ auto-chọn khu vực nếu chỉ 1 */
//     if (_staffAreaIds.length == 1) _selectedAreaId = _staffAreaIds.first;
//   }

//   /* ------------------------- TIME–SHIFT utils ---------------------------------- */
//   TimeOfDay _parseHHMM(String hhmm) {
//     final p = hhmm.split(':');
//     return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
//   }

//   bool _inRange(TimeOfDay start, TimeOfDay end, TimeOfDay now) {
//     final s = start.hour * 60 + start.minute;
//     final e = end.hour * 60 + end.minute;
//     final n = now.hour * 60 + now.minute;
//     return e < s ? (n >= s || n <= e) : (n >= s && n <= e);
//   }

//   /* ------------------------- UI helpers ---------------------------------------- */
//   String _areaName(int id) => areas.firstWhere((a) => a['id'] == id)['name'];

//   List<Map<String, dynamic>> _tablesForDropdown() {
//     if (_isStaff) {
//       return _staffTables
//           .where(
//             (t) =>
//                 (_selectedAreaId == null || t['area_id'] == _selectedAreaId) &&
//                 t['status'] != 'Đã đặt' &&
//                 t['status'] != 'Đang dùng',
//           )
//           .toList();
//     }
//     return tables
//         .where(
//           (t) =>
//               t['area_id'] == _selectedAreaId &&
//               t['status'] != 'Đã đặt' &&
//               t['status'] != 'Đang dùng',
//         )
//         .toList();
//   }

//   /* ------------------------- BUILD -------------------------------------------- */
//   @override
//   Widget build(BuildContext context) {
//     final tablesDropdown = _tablesForDropdown();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Tạo đơn hàng')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           /* --------- KHU VỰC ------------------------------------------------- */
//           DropdownButtonFormField<int>(
//             value: _selectedAreaId,
//             decoration: const InputDecoration(labelText: 'Khu vực'),
//             items:
//                 (_isStaff ? _staffAreaIds : areas.map((a) => a['id']))
//                     .map(
//                       (id) => DropdownMenuItem<int>(
//                         value: id as int,
//                         child: Text(_areaName(id)),
//                       ),
//                     )
//                     .toList(),
//             onChanged:
//                 (_isStaff && _staffAreaIds.length == 1)
//                     ? null
//                     : (v) => setState(() {
//                       _selectedAreaId = v;
//                       _selectedTableId = null;
//                     }),
//             disabledHint: Text(
//               _isStaff
//                   ? (_staffAreaIds.isEmpty
//                       ? 'Không có ca hôm nay'
//                       : _areaName(_selectedAreaId ?? _staffAreaIds.first))
//                   : 'Chọn khu vực',
//             ),
//           ),

//           const SizedBox(height: 12),

//           /* --------- BÀN ---------------------------------------------------- */
//           DropdownButtonFormField<int>(
//             value: _selectedTableId,
//             decoration: const InputDecoration(labelText: 'Bàn'),
//             items:
//                 tablesDropdown
//                     .map(
//                       (t) => DropdownMenuItem<int>(
//                         value: t['id'] as int,
//                         child: Text(
//                           'Bàn ${t['id']} • ${t['seat_count']} chỗ • ${t['status']}',
//                         ),
//                       ),
//                     )
//                     .toList(),
//             onChanged:
//                 tablesDropdown.isEmpty
//                     ? null
//                     : (v) => setState(() => _selectedTableId = v),
//             disabledHint: Text(
//               _selectedAreaId == null
//                   ? (_isStaff
//                       ? 'Chọn khu vực (trong ca)'
//                       : 'Chọn khu vực trước')
//                   : 'Chưa có bàn trống ở khu vực này',
//             ),
//           ),

//           const Divider(height: 32),

//           /* --------- CHỌN MÓN ---------------------------------------------- */
//           const Text('Chọn món', style: TextStyle(fontWeight: FontWeight.bold)),
//           ...dishes.map((d) {
//             final id = d['id'] as int;
//             final name = d['name'];
//             final price = int.parse(d['price']);
//             final qty = _dishQty[id] ?? 0;
//             return ListTile(
//               title: Text(name),
//               subtitle: Text('Giá: $price đ'),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.remove),
//                     onPressed:
//                         qty > 0
//                             ? () => setState(() => _dishQty[id] = qty - 1)
//                             : null,
//                   ),
//                   Text('$qty'),
//                   IconButton(
//                     icon: const Icon(Icons.add),
//                     onPressed: () => setState(() => _dishQty[id] = qty + 1),
//                   ),
//                 ],
//               ),
//             );
//           }),

//           const Divider(height: 32),

//           /* --------- GHI CHÚ ------------------------------------------------ */
//           TextField(
//             controller: _note,
//             decoration: const InputDecoration(
//               labelText: 'Ghi chú',
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 2,
//           ),

//           const SizedBox(height: 16),

//           /* --------- NÚT LƯU ------------------------------------------------ */
//           ElevatedButton.icon(
//             icon: const Icon(Icons.check),
//             label: const Text('Lưu đơn'),
//             onPressed:
//                 (_selectedTableId != null && _dishQty.values.any((q) => q > 0))
//                     ? _saveOrder
//                     : null,
//           ),
//         ],
//       ),
//     );
//   }

//   /* ------------------------- SAVE ORDER --------------------------------------- */
//   void _saveOrder() {
//     final total = _dishQty.entries.fold<int>(0, (sum, e) {
//       final price = int.parse(
//         dishes.firstWhere((d) => d['id'] == e.key)['price'],
//       );
//       return sum + price * e.value;
//     });

//     final order = {
//       'customer': widget.role == 'Khách hàng' ? widget.name : null,
//       'staff': _isStaff ? widget.name : null,
//       'area_id': _selectedAreaId,
//       'table_id': _selectedTableId,
//       'order_time': DateTime.now().toIso8601String(),
//       'note': _note.text,
//       'total': total,
//       'details':
//           _dishQty.entries
//               .where((e) => e.value > 0)
//               .map((e) => {'dish_id': e.key, 'quantity': e.value})
//               .toList(),
//       'status': 'Chờ xử lý',
//     };

//     Navigator.pop(context, order);
//   }

//   @override
//   void dispose() {
//     _note.dispose();
//     super.dispose();
//   }
// }
// //resssssssssulttttttttt
// import 'package:flutter/material.dart';
// import '../data/mock_data.dart';
// import 'package:dt02_nhom09/screens/order_mode.dart';

// class AddOrderScreen extends StatefulWidget {
//   final OrderMode mode;
//   final String name;
//   final String role;

//   const AddOrderScreen({
//     super.key,
//     required this.mode,
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
//   int? staffId;
//   late List<Map<String, dynamic>> staffTables; // bàn trong ca hôm nay
//   late Set<int> staffAreas; // area_id trong ca

//   /* ------------------------------------------------------------------ */
//   /*                              INIT                                  */
//   /* ------------------------------------------------------------------ */
//   @override
//   void initState() {
//     super.initState();
//     isStaff = widget.role == 'Nhân viên';

//     if (isStaff) _prepareShiftData(); // tính staffTables, staffAreas

//     // Nếu staff và đã auto-chọn khu vực thì cũng auto-lọc bàn
//     if (isStaff && selectedAreaId != null) _filterTables();
//   }

//   void _prepareShiftData() {
//     /* 1. lấy id nhân viên */
//     staffId =
//         users.firstWhere(
//           (u) => u['fullname'] == widget.name,
//           orElse: () => {},
//         )['id'];

//     /* 2. xác định shift hiện tại */
//     final shiftId = _currentShiftId();
//     if (shiftId == null || staffId == null) {
//       staffTables = [];
//       staffAreas = {};
//       return;
//     }

//     /* 3. bàn nhân viên phụ trách hôm nay */
//     final today = DateTime.now().toIso8601String().substring(0, 10);
//     final tableIds =
//         staffShiftAreas
//             .where(
//               (ssa) =>
//                   ssa['staff_id'] == staffId &&
//                   ssa['shift_id'] == shiftId &&
//                   ssa['date'] == today,
//             )
//             .map<int>((e) => e['table_id'])
//             .toSet();

//     staffTables = tables.where((t) => tableIds.contains(t['id'])).toList();
//     staffAreas = staffTables.map<int>((t) => t['area_id']).toSet();

//     /* 4. nếu chỉ 1 khu vực ⇒ chọn luôn & disable dropdown */
//     if (staffAreas.length == 1) selectedAreaId = staffAreas.first;
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

//   int? _currentShiftId() {
//     final now = TimeOfDay.now();
//     for (final s in shifts) {
//       if (_inRange(_parse(s['start_time']), _parse(s['end_time']), now)) {
//         return s['id'] as int;
//       }
//     }
//     return null;
//   }

//   /* ------------------------------------------------------------------ */
//   /*                         FILTER TABLES                              */
//   /* ------------------------------------------------------------------ */
//   void _filterTables() {
//     if (selectedAreaId == null) {
//       filteredTables = [];
//       return;
//     }

//     final source = isStaff ? staffTables : tables;
//     filteredTables =
//         source
//             .where(
//               (t) =>
//                   t['area_id'] == selectedAreaId &&
//                   t['status'] != 'Đã đặt' &&
//                   t['status'] != 'Đang dùng',
//             )
//             .toList();
//   }

//   /* ------------------------------------------------------------------ */
//   /*                        UI CALLBACKS                                */
//   /* ------------------------------------------------------------------ */
//   void onSelectArea(int? id) {
//     setState(() {
//       selectedAreaId = id;
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
//             _areaDropdown(areas.map((a) => a['id'] as int).toList()),
//             const SizedBox(height: 10),
//             _tableDropdown(),
//             const SizedBox(height: 10),
//             _timePickerRow(), // khách chọn giờ
//             const Divider(),
//           ] else ...[
//             /* -- Nhân viên: chỉ khu vực/bàn trong ca -- */
//             _areaDropdown(staffAreas.toList()),
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
//           ...dishes.map(_dishTile),

//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: _canSubmit ? _submitOrder : null,
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
//           areaIds
//               .map(
//                 (id) => DropdownMenuItem(
//                   value: id,
//                   child: Text(areas.firstWhere((a) => a['id'] == id)['name']),
//                 ),
//               )
//               .toList(),
//       onChanged: (isStaff && areaIds.length == 1) ? null : onSelectArea,
//       disabledHint: Text(
//         isStaff
//             ? (areaIds.isEmpty
//                 ? 'Không có ca hôm nay'
//                 : areas.firstWhere((a) => a['id'] == areaIds.first)['name'])
//             : 'Chọn khu vực',
//       ),
//     );
//   }

//   Widget _tableDropdown() {
//     return DropdownButtonFormField<int>(
//       decoration: const InputDecoration(labelText: 'Chọn bàn'),
//       value: selectedTableId,
//       items:
//           filteredTables
//               .map(
//                 (t) => DropdownMenuItem(
//                   value: t['id'] as int,
//                   child: Text(
//                     'Bàn ${t['id']} • ${t['seat_count']} chỗ • ${t['status']}',
//                   ),
//                 ),
//               )
//               .toList(),
//       onChanged: filteredTables.isEmpty ? null : onSelectTable,
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

// Widget _dishTile(Map<String, dynamic> d) {
//   final name = d['name'];
//   final price = int.parse(d['price']);
//   final qty = _selectedDishes[name] ?? 0;

//   return ListTile(
//     title: Text(name),
//     subtitle: Text('Giá: $price đ'),
//     trailing: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.remove),
//           onPressed:
//               qty > 0
//                   ? () => setState(() => _selectedDishes[name] = qty - 1)
//                   : null,
//         ),
//         Text('$qty'),
//         IconButton(
//           icon: const Icon(Icons.add),
//           onPressed: () => setState(() => _selectedDishes[name] = qty + 1),
//         ),
//       ],
//     ),
//   );
// }

//   /* ---------------------- SUBMIT ORDER -------------------------------------- */
//   // bool get _canSubmit =>
//   //     selectedTableId != null && _selectedDishes.values.any((q) => q > 0);

//   // void _submitOrder() {
//   //   final total = _selectedDishes.entries.fold<int>(0, (s, e) {
//   //     final price = int.parse(
//   //       dishes.firstWhere((d) => d['name'] == e.key)['price'],
//   //     );
//   //     return s + price * e.value;
//   //   });

//   //   final orderMap = {
//   //     'customer': widget.role == 'Khách hàng' ? widget.name : null,
//   //     'staff': isStaff ? widget.name : null,
//   //     'area_id': selectedAreaId,
//   //     'table_id': selectedTableId,
//   //     'order_time': DateTime.now().toIso8601String(), // luôn lấy NOW
//   //     'note': _noteController.text,
//   //     'total': total,
//   //     'status': 'Chờ xử lý',
//   //     'details':
//   //         _selectedDishes.entries
//   //             .where((e) => e.value > 0)
//   //             .map((e) => {'dish': e.key, 'quantity': e.value})
//   //             .toList(),
//   //   };

//   //   Navigator.pop(context, orderMap);
//   // }
//   bool get _canSubmit {
//     // logic kiểm tra
//     return selectedTableId != null && _selectedDishes.values.any((q) => q > 0);
//   }
//   // bool get _canSubmit {
//   //   if (!_canSubmit) return false;
//   //   // Nếu là nhân viên phục vụ, cần nhập họ tên & số điện thoại
//   //   if (isStaff) {
//   //     return _customerNameController.text.trim().isNotEmpty &&
//   //         _customerPhoneController.text.trim().isNotEmpty;
//   //   }
//   //   return true;
//   // }

//   void _submitOrder() {
//     final total = _selectedDishes.entries.fold<int>(0, (s, e) {
//       final price = int.parse(
//         dishes.firstWhere((d) => d['name'] == e.key)['price'],
//       );
//       return s + price * e.value;
//     });

//     final orderMap = {
//       'customer':
//           isStaff
//               ? _customerNameController.text.trim()
//               : (widget.role == 'Khách hàng' ? widget.name : null),
//       'customer_phone': isStaff ? _customerPhoneController.text.trim() : null,
//       'staff': isStaff ? widget.name : null,
//       'area_id': selectedAreaId,
//       'table_id': selectedTableId,
//       'order_time': DateTime.now().toIso8601String(),
//       'note': _noteController.text,
//       'total': total,
//       'status': 'Chờ xử lý',
//       'details':
//           _selectedDishes.entries
//               .where((e) => e.value > 0)
//               .map((e) => {'dish': e.key, 'quantity': e.value})
//               .toList(),
//     };

//     Navigator.pop(context, orderMap);
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

//test db
import 'package:dt02_nhom09/class/area.dart';
import 'package:dt02_nhom09/class/listFood.dart';
import 'package:dt02_nhom09/class/order_detail.dart';
import 'package:dt02_nhom09/class/order_model.dart';
import 'package:dt02_nhom09/class/table_model.dart';
import 'package:dt02_nhom09/class/user.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
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
  final Map<String, int> _selectedDishes = {}; // dishName -> qty
  List<Map<String, dynamic>> filteredTables = [];
  //thông tin khách
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  /* ---------- flag & dữ liệu riêng cho staff ---------- */
  late final bool isStaff;
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

          ...listDishes.map(_dishTile),
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
    final qty = _selectedDishes[name] ?? 0;

    return ListTile(
      title: Text(name),
      subtitle: Text('Giá: $price đ'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed:
                qty > 0
                    ? () => setState(() => _selectedDishes[name] = qty - 1)
                    : null,
          ),
          Text('$qty'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _selectedDishes[name] = qty + 1),
          ),
        ],
      ),
    );
  }

  bool get _canSubmit {
    return selectedTableId != null && _selectedDishes.values.any((q) => q > 0);
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

      final total = _selectedDishes.entries.fold<double>(0.0, (s, e) {
        final matched = listDishes.where((d) => d.name == e.key).toList();
        if (matched.isEmpty) return s;

        final dish = matched.first;
        print('Check dish khi sử dụng: listDishes $dish');
        // print('Hiển thị thông tin dish món chọn $dish');
        return s + dish.price * e.value;
      });

      print('Tổng tiền: $total');
      // 3. Tạo đơn hàng (Order)
      final order = Order(
        id: 0, // sẽ được auto tăng
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

      // 4. Chi tiết đơn hàng (OrderDetail)

      final orderDetails =
          _selectedDishes.entries
              .where((e) => e.value > 0)
              .map((e) {
                final matched =
                    listDishes.where((d) => d.name == e.key).toList();
                if (matched.isEmpty) {
                  print('Không tìm thấy món: ${e.key}');
                  return null; // hoặc bỏ qua món này tùy logic bạn muốn
                }
                final dish = matched.first;
                print('Dữ liệu trong bảng order detail');
                print('Món đặt: ${e.key}');
                print('Dish id: ${dish.id}');
                return OrderDetail(
                  orderId: null,
                  dishId: dish.id,
                  quantity: e.value,
                  status: 'Chờ xử lý',
                  chefId: null,
                  createdAt: now.toIso8601String(),
                  updatedAt: now.toIso8601String(),
                );
              })
              .whereType<OrderDetail>()
              .toList(); // loại bỏ null nếu có

      // 5. Lưu vào DB
      final orderId = await db.insertOrder(order);
      for (var detail in orderDetails) {
        detail.orderId = orderId;
      }
      await db.insertOrderDetails(orderDetails);

      // 6. Thông báo thành công
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đặt món thành công!')));
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
