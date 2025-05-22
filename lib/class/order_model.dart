class Order {
  final int id;
  final String tableName;
  final int staffId;
  final String status; // “Chờ xử lý”, ...
  final int totalAmount;
  final DateTime createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.tableName,
    required this.staffId,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    required this.items,
  });
}

class OrderItem {
  final int id;
  final String dishName;
  final int price;
  final int quantity;
  final String status; // “Đã đặt”, “Đang chế biến”, “Hoàn thành”
  final int? chefId;

  OrderItem({
    required this.id,
    required this.dishName,
    required this.price,
    required this.quantity,
    required this.status,
    this.chefId,
  });
}
