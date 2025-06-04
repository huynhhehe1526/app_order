import 'package:dt02_nhom09/class/Registrationshift.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:dt02_nhom09/screens/modalCrud/addRegisterShiftSheet.dart';
import 'package:flutter/material.dart';

enum ShiftStatus { upcoming, ongoing, ended }

class ShiftListScreen extends StatefulWidget {
  final String? role;
  final int? userId;

  const ShiftListScreen({this.role, this.userId, super.key});

  @override
  State<ShiftListScreen> createState() => _ShiftListScreenState();
}

class _ShiftListScreenState extends State<ShiftListScreen> {
  late Future<List<Registrationshift>> _future;
  DatabaseHelper db = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<Registrationshift>> _load() async {
    try {
      if (widget.userId != null) {
        final rows = await db.getTodayShiftsByStaff(widget.userId!);
        return rows.map((e) => Registrationshift.fromMap(e)).toList();
      } else {
        final rows = await db.getTodayShiftsByRole(
          widget.role!,
        ); // dùng lại db thay vì new instance
        return rows.map((e) => Registrationshift.fromMap(e)).toList();
      }
    } catch (e) {
      print('Lỗi khi load dữ liệu: $e');
      return [];
    }
  }

  ShiftStatus getShiftStatus(String start, String end) {
    String fixTimeFormat(String time) => time.replaceAll('h', ':');

    TimeOfDay now = TimeOfDay.now();

    TimeOfDay parse(String time) {
      time = fixTimeFormat(time);
      final parts = time.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    TimeOfDay startTime = parse(start);
    TimeOfDay endTime = parse(end);

    bool afterStart =
        (now.hour > startTime.hour) ||
        (now.hour == startTime.hour && now.minute >= startTime.minute);
    bool beforeEnd =
        (now.hour < endTime.hour) ||
        (now.hour == endTime.hour && now.minute <= endTime.minute);

    if (afterStart && beforeEnd) return ShiftStatus.ongoing;
    if (!afterStart) return ShiftStatus.upcoming;
    return ShiftStatus.ended;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ca làm việc hôm nay')),
      body: FutureBuilder<List<Registrationshift>>(
        future: _future,
        builder: (ctx, snap) {
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          final list = snap.data!;
          if (list.isEmpty) return const Center(child: Text('Chưa có ca làm'));
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final s = list[i];
              final status = getShiftStatus(s.startTime, s.endTime);

              final icon =
                  {
                    ShiftStatus.ongoing: Icons.timer,
                    ShiftStatus.upcoming: Icons.schedule,
                    ShiftStatus.ended: Icons.lock_clock,
                  }[status];

              final color =
                  {
                    ShiftStatus.ongoing: Colors.green,
                    ShiftStatus.upcoming: Colors.blueGrey,
                    ShiftStatus.ended: Colors.red,
                  }[status];

              final statusText =
                  {
                    ShiftStatus.ongoing: 'Đang làm',
                    ShiftStatus.upcoming: 'Sắp tới',
                    ShiftStatus.ended: 'Đã kết thúc',
                  }[status]!;

              return GestureDetector(
                onTap: () {
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color!.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: color, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${s.shiftName} (${s.startTime} - ${s.endTime})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.userId != null
                                  ? 'Bàn: ${s.table_id ?? '-'} | Khu vực: ${s.areaName ?? '-'}'
                                  : 'NV: ${s.staffName} | Bàn: ${s.table_id ?? '-'} | Khu vực: ${s.areaName ?? '-'}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.circle, size: 10, color: color),
                                const SizedBox(width: 6),
                                Text(
                                  statusText,
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Trả về true nếu đăng ký thành công
          final bool? didSave = await showModalBottomSheet<bool>(
            context: context,
            isScrollControlled: true,
            builder:
                (_) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: RegisterShiftSheet(
                    currentUserId: widget.userId,
                    db: db,
                  ),
                ),
          );
          if (didSave == true) {
            setState(() {
              _future =
                  _load(); 
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
