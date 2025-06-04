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
  late final bool isCustomer;
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
    isCustomer = widget.role == 'Khách';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Tạo đơn hàng mới')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /* ---------- KHÁCH / NHÂN VIÊN / QUẢN LÝ ---------- */
            if (isManage) ...[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _areaDropdown(
                        _listAreas.map((a) => a.id as int).toList(),
                      ),
                      const SizedBox(height: 10),
                      _tableDropdown(),
                      const SizedBox(height: 10),
                      _timePickerRow(),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _customerNameController,
                        decoration: const InputDecoration(
                          labelText: 'Họ tên khách',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _customerPhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Số điện thoại khách',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (isCustomer) ...[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _areaDropdown(
                        _listAreas.map((a) => a.id as int).toList(),
                      ),
                      const SizedBox(height: 10),
                      _tableDropdown(),
                      const SizedBox(height: 10),
                      _timePickerRow(),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _areaDropdown(
                        isStaff
                            ? staffAreas.toList()
                            : _listAreas.map((a) => a.id!).toList(),
                      ),
                      const SizedBox(height: 10),
                      _tableDropdown(),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _customerNameController,
                        decoration: const InputDecoration(
                          labelText: 'Họ tên khách',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _customerPhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Số điện thoại khách',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),

            /* ---------- GHI CHÚ ---------- */
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Ghi chú đơn hàng',
                    prefixIcon: Icon(Icons.note_alt_outlined),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /* ---------- CHỌN MÓN ---------- */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Danh sách món đã chọn',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    final dishes = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MenuScreen(role: widget.role),
                      ),
                    );
                    if (dishes != null && mounted) {
                      setState(() => _selectedDishes = dishes);
                    }
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text("Chọn món"),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Expanded(
              child:
                  _selectedDishes.isEmpty
                      ? const Center(child: Text('Chưa chọn món'))
                      : Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.separated(
                          itemCount: _selectedDishes.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, index) {
                            final dish = _selectedDishes[index];
                            return ListTile(
                              leading: const Icon(Icons.fastfood_outlined),
                              title: Text(dish.name),
                              subtitle: Text(
                                'Giá: ${dish.price.toStringAsFixed(0)} đ',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (dish.quantity > 1) {
                                          dish.quantity--;
                                        } else {
                                          _selectedDishes.removeAt(index);
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    '${dish.quantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        dish.quantity++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _submitOrder,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Xác nhận tạo đơn'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
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

  void _submitOrder() async {
    final now = DateTime.now();

    try {
      int? customerId;
      if ((isStaff || isManage) &&
          _customerNameController.text.trim().isNotEmpty) {
        final customerName = _customerNameController.text.trim();
        final customerPhone = _customerPhoneController.text.trim();

        final existingUser = await db.findUserBySDT(customerPhone);

        if (existingUser != null) {
          customerId = existingUser.id;
        } else {
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

      final total = _selectedDishes.fold<double>(
        0.0,
        (sum, dish) => sum + dish.price * dish.quantity,
      );

      print('Tổng tiền: $total');

      final order = Order(
        id: 0, // auto-increment
        customer_id: isCustomer ? widget.id : customerId,
        customerName: '',
        staffId: isStaff || isManage ? widget.id : null,
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
        print('map${d.toMap()}');
      }

      final savedDetails = await db.getOrderDetailsByOrderId(orderId);
      print('🔎 Kiểm tra OrderDetails đã lưu cho orderId = $orderId:');
      for (var d in savedDetails) {
        print(
          ' - dish_name: ${d['dish_name']}, quantity: ${d['quantity']}, status: ${d['status']}, chef_name: ${d['chef_name']}',
        );
      }
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
