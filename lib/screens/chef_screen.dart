import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data/mock_data.dart';

class ChefScreen extends StatefulWidget {
  final int chefId; // id của user role "Bếp"
  const ChefScreen({super.key, required this.chefId});

  @override
  State<ChefScreen> createState() => _ChefScreenState();
}

class _ChefScreenState extends State<ChefScreen> {
  late List<Map<String, dynamic>> myShiftToday;
  late List<Map<String, dynamic>> myOrderDetails;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // 1️⃣ Ca làm việc hôm nay
    myShiftToday =
        staffShiftAreas
            .where(
              (e) =>
                  e['chef_id'] == null &&
                  e['staff_id'] == widget.chefId &&
                  e['date'] == today,
            )
            .toList();

    // 2️⃣ Danh sách món (orderDetails) của bếp
    myOrderDetails =
        orderDetails.where((e) => e['chef_id'] == widget.chefId).toList();
  }

  // Chuyển trạng thái vòng đời
  void _advanceStatus(Map<String, dynamic> item) {
    setState(() {
      switch (item['status']) {
        case 'Đã đặt':
          item['status'] = 'Đang chế biến';
          break;
        case 'Đang chế biến':
          item['status'] = 'Hoàn thành';
          break;
        default:
          break;
      }
    });
  }

  Color _statusColor(String s) {
    switch (s) {
      case 'Đang chế biến':
        return Colors.orange;
      case 'Hoàn thành':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn hình Bếp'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => setState(_loadData),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /* ------------------- Ca làm việc hôm nay -------------------- */
            Text(
              'Ca làm việc hôm nay',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...myShiftToday.map((shiftArea) {
              final shift = shifts.firstWhere(
                (s) => s['id'] == shiftArea['shift_id'],
              );
              final table = tables.firstWhere(
                (t) => t['id'] == shiftArea['table_id'],
              );
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.schedule, color: Colors.brown),
                  title: Text(
                    '${shift['shiftname']}  (${shift['start_time']} - ${shift['end_time']})',
                  ),
                  subtitle: Text(
                    'Bàn: #${table['id']} (${table['seat_count']} chỗ)',
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            /* ------------------- Danh sách món -------------------------- */
            Text(
              'Món cần chế biến',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...myOrderDetails.map((od) {
              final dish = dishes.firstWhere((d) => d['id'] == od['dish_id']);
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.brown.shade100,
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: Colors.brown,
                    ),
                  ),
                  title: Text(dish['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Số lượng: ${od['quantity']}'),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Chip(
                            label: Text(od['status']),
                            backgroundColor: _statusColor(
                              od['status'],
                            ).withOpacity(.15),
                            labelStyle: TextStyle(
                              color: _statusColor(od['status']),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing:
                      od['status'] == 'Hoàn thành'
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : IconButton(
                            icon: const Icon(Icons.play_arrow),
                            color: Colors.orange,
                            tooltip: 'Chuyển trạng thái',
                            onPressed: () => _advanceStatus(od),
                          ),
                ),
              );
            }),
            if (myOrderDetails.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Center(
                  child: Text(
                    'Hiện không có món nào cần chuẩn bị.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
