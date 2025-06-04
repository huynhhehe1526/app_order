//test DB
import 'package:dt02_nhom09/class/listFood.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:flutter/material.dart';

class ChefScreen extends StatefulWidget {
  final int chefId;
  const ChefScreen({super.key, required this.chefId});

  @override
  State<ChefScreen> createState() => _ChefScreenState();
}

class _ChefScreenState extends State<ChefScreen> {
  List<Map<String, dynamic>> myOrderDetails = [];
  DatabaseHelper db = DatabaseHelper();
  List<Dish> dishes = [];

  @override
  void initState() {
    super.initState();
    _loadDishes();
    _loadData();
  }

  void _loadDishes() async {
    dishes = await db.getAllDishes();
    print("🔍 Món cần chế biến: $myOrderDetails");
    setState(() {});
  }

  void _loadData() async {
    myOrderDetails = await db.getDishesToPrepare();
    print("🔍 Món cần chế biến: $myOrderDetails");
    setState(() {});
  }

  void _advanceStatus(Map<String, dynamic> item) async {
    String currentStatus = item['status'];
    String? newStatus;

    switch (currentStatus) {
      case 'Chờ xử lý':
        newStatus = 'Đang chế biến';
        break;
      case 'Đang chế biến':
        newStatus = 'Hoàn thành';
        break;
    }

    if (newStatus != null) {
      await db.updateOrderDetailStatus(item['id'], newStatus);

      _loadData();

      if (newStatus == 'Hoàn thành') {
        await Future.delayed(const Duration(seconds: 2));
        await db.updateOrderDetailChef(item['id'], widget.chefId);

        _loadData();
      }
    }
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

  //check
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👨‍🍳 Màn hình Bếp'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => setState(_loadData),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              Text(
                '🍽️ Món cần chế biến',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 12),

              // Hiển thị nếu không có món
              if (myOrderDetails.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(
                    child: Text(
                      '✅ Hiện không có món nào cần chuẩn bị.',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),

              // Danh sách món
              ...myOrderDetails.map((od) {
                final status = od['status'];
                final isDone = status == 'Hoàn thành';

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.orange.shade100,
                        child: const Icon(
                          Icons.restaurant_menu,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              od['dish_name'] ?? 'Không rõ tên món',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Số lượng: ${od['quantity']}'),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  isDone
                                      ? Icons.check_circle
                                      : status == 'Đang chế biến'
                                      ? Icons.local_fire_department
                                      : Icons.pending,
                                  color: _statusColor(status),
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  status,
                                  style: TextStyle(color: _statusColor(status)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (!isDone)
                        IconButton(
                          icon: const Icon(Icons.play_arrow),
                          color: Colors.orange,
                          onPressed: () => _advanceStatus(od),
                          tooltip: 'Chuyển trạng thái',
                        )
                      else
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
