import 'package:dt02_nhom09/class/area.dart';
import 'package:dt02_nhom09/class/shift.dart';
import 'package:dt02_nhom09/class/table_model.dart';
import 'package:dt02_nhom09/class/user.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterShiftSheet extends StatefulWidget {
  final DatabaseHelper db;
  final int? currentUserId; 

  const RegisterShiftSheet({required this.db, this.currentUserId, super.key});

  @override
  State<RegisterShiftSheet> createState() => _RegisterShiftSheetState();
}

class _RegisterShiftSheetState extends State<RegisterShiftSheet> {
  int? _selectedAreaId;
  int? _selectedTableId;
  int? _selectedShiftId;
  DateTime _selectedDate = DateTime.now();
  int? _selectedStaffId; // Chỉ dùng khi quản lý tạo

  late Future<List<Area>> _areasF;
  late Future<List<Shift>> _shiftsF;

  @override
  void initState() {
    super.initState();
    _areasF = widget.db.getAllAreas();
    _shiftsF = widget.db.getAllShifts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Đăng ký ca làm',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            /// --- KHU VỰC ---
            FutureBuilder<List<Area>>(
              future: _areasF,
              builder: (_, snap) {
                if (!snap.hasData) return const CircularProgressIndicator();
                final areas = snap.data!;
                return DropdownButtonFormField<int>(
                  value: _selectedAreaId,
                  items:
                      areas
                          .map(
                            (a) => DropdownMenuItem(
                              value: a.id,
                              child: Text(a.name),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (v) => setState(() {
                        _selectedAreaId = v;
                        _selectedTableId = null; // reset bàn
                      }),
                  decoration: const InputDecoration(labelText: 'Khu vực'),
                );
              },
            ),

            /// --- BÀN ---
            if (_selectedAreaId != null)
              FutureBuilder<List<TableModel>>(
                future: widget.db.getTablesByArea(_selectedAreaId!),
                builder: (_, snap) {
                  if (!snap.hasData) return const CircularProgressIndicator();
                  final tables =
                      snap.data!.where((t) => t.status == 'Trống').toList();
                  return DropdownButtonFormField<int>(
                    value: _selectedTableId,
                    items:
                        tables
                            .map(
                              (t) => DropdownMenuItem(
                                value: t.id,
                                child: Text('Bàn ${t.id} (${t.seatCount} chỗ)'),
                              ),
                            )
                            .toList(),
                    onChanged: (v) => setState(() => _selectedTableId = v),
                    decoration: const InputDecoration(labelText: 'Bàn'),
                  );
                },
              ),

            /// --- CA LÀM ---
            const SizedBox(height: 8),
            FutureBuilder<List<Shift>>(
              future: _shiftsF,
              builder: (_, snap) {
                if (!snap.hasData) return const CircularProgressIndicator();
                final shifts = snap.data!;
                return DropdownButtonFormField<int>(
                  value: _selectedShiftId,
                  items:
                      shifts
                          .map(
                            (s) => DropdownMenuItem(
                              value: s.id,
                              child: Text(
                                '${s.shiftname} (${s.startTime}-${s.endTime})',
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (v) => setState(() => _selectedShiftId = v),
                  decoration: const InputDecoration(labelText: 'Ca làm'),
                );
              },
            ),

            /// --- NGÀY ---
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (picked != null) setState(() => _selectedDate = picked);
              },
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Ngày làm'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                    const Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),

            /// --- STAFF (nếu là quản lý) ---
            if (widget.currentUserId == null) ...[
              const SizedBox(height: 8),
              FutureBuilder<List<User>>(
                future: widget.db.getAllUsers(), // lọc role 'Nhân viên' nếu cần
                builder: (_, snap) {
                  if (!snap.hasData) return const CircularProgressIndicator();
                  final staff = snap.data!.where((u) => u.role == 'Nhân viên');
                  return DropdownButtonFormField<int>(
                    value: _selectedStaffId,
                    items:
                        staff
                            .map(
                              (u) => DropdownMenuItem(
                                value: u.id,
                                child: Text(u.fullname),
                              ),
                            )
                            .toList(),
                    onChanged: (v) => setState(() => _selectedStaffId = v),
                    decoration: const InputDecoration(labelText: 'Nhân viên'),
                  );
                },
              ),
            ],

            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Lưu'),
              onPressed: _onSave,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (_selectedAreaId == null ||
        _selectedTableId == null ||
        _selectedShiftId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn đủ thông tin.')),
      );
      return;
    }

    final staffId = widget.currentUserId ?? _selectedStaffId;
    if (staffId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Chưa chọn nhân viên.')));
      return;
    }

    await widget.db.database.then(
      (db) => db.insert('StaffShiftArea', {
        'shift_id': _selectedShiftId,
        'staff_id': staffId,
        'table_id': _selectedTableId,
        'created_at': DateFormat('yyyy-MM-dd').format(_selectedDate),
        'updated_at': DateTime.now().toIso8601String(),
      }),
    );

    Navigator.pop(context, true); 
  }
}
