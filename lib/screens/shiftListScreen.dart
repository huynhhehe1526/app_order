import 'package:dt02_nhom09/class/Registrationshift.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:dt02_nhom09/screens/modalCrud/addRegisterShiftSheet.dart';
import 'package:flutter/material.dart';

enum ShiftStatus { upcoming, ongoing, ended }

class ShiftListScreen extends StatefulWidget {
  /// Nếu truyền role → xem theo role (dành cho Quản lý)
  final String? role;

  /// Nếu truyền userId → xem ca của chính nhân viên
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

  // Future<List<Registrationshift>> _load() async {
  //   if (widget.userId != null) {
  //     final rows = await db.getTodayShiftsByStaff(widget.userId!);
  //     return rows.map((e) => Registrationshift.fromMap(e)).toList();
  //   } else {
  //     final rows = await DatabaseHelper().getTodayShiftsByRole(widget.role!);
  //     return rows.map((e) => Registrationshift.fromMap(e)).toList();
  //   }
  // }

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
      return []; // Trả về danh sách rỗng thay vì để treo
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

  // bool isCurrentShift(String start, String end) {
  //   String fixTimeFormat(String time) {
  //     return time.replaceAll('h', ':');
  //   }

  //   final now = TimeOfDay.now();

  //   TimeOfDay parseTime(String time) {
  //     time = fixTimeFormat(time);
  //     final parts = time.split(':');
  //     return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  //   }

  //   TimeOfDay startTime = parseTime(start);
  //   TimeOfDay endTime = parseTime(end);

  //   bool afterStart =
  //       (now.hour > startTime.hour) ||
  //       (now.hour == startTime.hour && now.minute >= startTime.minute);
  //   bool beforeEnd =
  //       (now.hour < endTime.hour) ||
  //       (now.hour == endTime.hour && now.minute <= endTime.minute);

  //   return afterStart && beforeEnd;
  // }

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

          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              final s = list[i];
              // return ListTile(
              //   leading: const Icon(Icons.schedule),
              //   title: Text('${s.shiftName}: ${s.startTime} - ${s.endTime}'),
              //   subtitle:
              //       widget.userId != null
              //           ? Text('Bàn: ${s.table_id ?? '-'}')
              //           : Text(
              //             'NV: ${s.staffName}  |  Bàn: ${s.table_id ?? '-'}',
              //           ),
              // );

              //test
              // return Container(
              //   decoration: BoxDecoration(
              //     border:
              //         isCurrentShift(s.startTime, s.endTime)
              //             ? Border.all(color: Colors.green, width: 2)
              //             : null,
              //     borderRadius: BorderRadius.circular(8),
              //     color:
              //         isCurrentShift(s.startTime, s.endTime)
              //             ? Colors.green.withOpacity(0.1)
              //             : null,
              //   ),
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.schedule,
              //       color:
              //           isCurrentShift(s.startTime, s.endTime)
              //               ? Colors.green
              //               : null,
              //     ),
              //     title: Text('${s.shiftName}: ${s.startTime} - ${s.endTime}'),
              //     subtitle:
              //         widget.userId != null
              //             ? Text('Bàn: ${s.table_id ?? '-'}')
              //             : Text(
              //               'NV: ${s.staffName}  |  Bàn: ${s.table_id ?? '-'}',
              //             ),
              //   ),
              // );

              //test cuối
              // return ListTile(
              //   leading:
              //       isCurrentShift(s.startTime, s.endTime)
              //           ? Icon(
              //             Icons.timer,
              //             color: Colors.green,
              //           ) // Ca đang làm → icon khác
              //           : Icon(Icons.schedule),
              //   title: Text('${s.shiftName}: ${s.startTime} - ${s.endTime}'),
              //   subtitle:
              //       widget.userId != null
              //           ? Text('Bàn: ${s.table_id ?? '-'}')
              //           : Text(
              //             'NV: ${s.staffName}  |  Bàn: ${s.table_id ?? '-'} |  Khu vực: ${s.areaName ?? '-'}',
              //           ),
              // );

              //tessssssssssss
              return ListTile(
                leading: Icon(
                  () {
                    final status = getShiftStatus(s.startTime, s.endTime);
                    switch (status) {
                      case ShiftStatus.ongoing:
                        return Icons.timer; // đang làm
                      case ShiftStatus.upcoming:
                        return Icons.schedule; // chưa đến
                      case ShiftStatus.ended:
                        return Icons.lock_clock; // đã kết thúc
                    }
                  }(),
                  color: () {
                    final status = getShiftStatus(s.startTime, s.endTime);
                    switch (status) {
                      case ShiftStatus.ongoing:
                        return Colors.green;
                      case ShiftStatus.upcoming:
                        return Colors.blueGrey;
                      case ShiftStatus.ended:
                        return Colors.red;
                    }
                  }(),
                ),
                title: Text('${s.shiftName}: ${s.startTime} - ${s.endTime}'),
                subtitle:
                    widget.userId != null
                        ? Text(
                          'Bàn: ${s.table_id ?? '-'} | Khu vực: ${s.areaName ?? '-'}',
                        )
                        : Text(
                          'NV: ${s.staffName} | Bàn: ${s.table_id ?? '-'} | Khu vực: ${s.areaName ?? '-'}',
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

          // if (didSave == true) {
          //   // load lại dữ liệu
          //   setState(() => _future = _load());
          // }
          if (didSave == true) {
            setState(() {
              _future =
                  _load(); // vẫn gọi hàm async, nhưng callback returns void
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
