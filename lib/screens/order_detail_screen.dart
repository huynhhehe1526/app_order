import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final order =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text("Chi tiết đơn #${order['id']}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "👤 Khách hàng: ${order['customer']}",
              style: TextStyle(fontSize: 16),
            ),
            Text("👨‍💼 Nhân viên: ${order['staff']}"),
            Text(
              "📌 Trạng thái: ${order['status']}",
              style: TextStyle(color: Colors.blue),
            ),
            Text("📝 Ghi chú: ${order['note']}"),
            SizedBox(height: 10),
            Text(
              "🍽️ Danh sách món:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order['details'].length,
                itemBuilder: (context, index) {
                  final item = order['details'][index];
                  return Card(
                    child: ListTile(
                      title: Text("${item['dish']} x${item['quantity']}"),
                      subtitle: Text("Trạng thái: ${item['status']}"),
                      trailing:
                          item['chef'] != null
                              ? Text("👨‍🍳 ${item['chef']}")
                              : null,
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              "💵 Tổng cộng: ${order['total']}đ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle),
                label: Text("Quay lại"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                label: const Text("Thanh toán"),
                onPressed: () {
                  Navigator.pushNamed(context, '/payment', arguments: order);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
