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
      padding:
          MediaQuery.of(context).viewInsets, 
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🕐 Đăng ký ca làm',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// --- KHU VỰC ---
            Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: FutureBuilder<List<Area>>(
                  future: _areasF,
                  builder: (_, snap) {
                    if (!snap.hasData) return const LinearProgressIndicator();
                    final areas = snap.data!;
                    return DropdownButtonFormField<int>(
                      value: _selectedAreaId,
                      decoration: const InputDecoration(labelText: 'Khu vực'),
                      items:
                          areas
                              .map(
                                (a) => DropdownMenuItem(
                                  value: a.id,
                                  child: Text(a.name),
                                ),
                              )
                              .toList(),
                      onChanged: (v) {
                        setState(() {
                          _selectedAreaId = v;
                          _selectedTableId = null;
                        });
                      },
                    );
                  },
                ),
              ),
            ),

            /// --- BÀN ---
            if (_selectedAreaId != null) ...[
              const SizedBox(height: 12),
              Card(
                margin: EdgeInsets.zero,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: FutureBuilder<List<TableModel>>(
                    future: widget.db.getTablesByArea(_selectedAreaId!),
                    builder: (_, snap) {
                      if (!snap.hasData) {
                        return const LinearProgressIndicator();
                      }
                      final tables =
                          snap.data!.where((t) => t.status == 'Trống').toList();
                      return DropdownButtonFormField<int>(
                        value: _selectedTableId,
                        decoration: const InputDecoration(
                          labelText: 'Chọn bàn',
                        ),
                        items:
                            tables
                                .map(
                                  (t) => DropdownMenuItem(
                                    value: t.id,
                                    child: Text(
                                      'Bàn ${t.id} (${t.seatCount} chỗ)',
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) => setState(() => _selectedTableId = v),
                      );
                    },
                  ),
                ),
              ),
            ],

            /// --- CA LÀM ---
            const SizedBox(height: 12),
            Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: FutureBuilder<List<Shift>>(
                  future: _shiftsF,
                  builder: (_, snap) {
                    if (!snap.hasData) return const LinearProgressIndicator();
                    final shifts = snap.data!;
                    return DropdownButtonFormField<int>(
                      value: _selectedShiftId,
                      decoration: const InputDecoration(labelText: 'Ca làm'),
                      items:
                          shifts
                              .map(
                                (s) => DropdownMenuItem(
                                  value: s.id,
                                  child: Text(
                                    '${s.shiftname} (${s.startTime} - ${s.endTime})',
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => _selectedShiftId = v),
                    );
                  },
                ),
              ),
            ),

            /// --- NGÀY ---
            const SizedBox(height: 12),
            Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                title: const Text('Ngày làm'),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 30),
                      ),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                ),
              ),
            ),

            /// --- NHÂN VIÊN (nếu là quản lý) ---
            if (widget.currentUserId == null) ...[
              const SizedBox(height: 12),
              Card(
                margin: EdgeInsets.zero,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: FutureBuilder<List<User>>(
                    future: widget.db.getAllUsers(),
                    builder: (_, snap) {
                      if (!snap.hasData) return const LinearProgressIndicator();
                      final staff =
                          snap.data!
                              .where((u) => u.role == 'Nhân viên')
                              .toList();
                      return DropdownButtonFormField<int>(
                        value: _selectedStaffId,
                        decoration: const InputDecoration(
                          labelText: 'Nhân viên',
                        ),
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
                      );
                    },
                  ),
                ),
              ),
            ],

            /// --- NÚT LƯU ---
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _onSave,
              icon: const Icon(Icons.save_alt),
              label: const Text('Lưu đăng ký'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
