class Order {
  final int id;
  final int? customer_id;
  final String? customerName;
  final int? staffId;
  final String staffName;
  final int table_id;
  final String areaName;
  final String status; //"Chờ xử lý", "Đã đặt", "Đang tiến hành"
  final int totalAmount;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final List<OrderItem> items;

  Order({
    required this.id,
    this.customer_id,
    this.customerName,
    required this.staffId,
    required this.staffName,
    required this.table_id,
    required this.areaName,
    required this.status,
    required this.totalAmount,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    // required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customer_id,
      'customerName': customerName,
      'staff_id': staffId,
      'staffName': staffName,
      'table_id': table_id,
      'areaName': areaName,
      'status': status,
      'total_amount': totalAmount,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      customer_id: map['customer_id'] as int?, // có thể null
      customerName: map['customerName'] as String? ?? '',
      staffId: map['staff_id'] as int?, // có thể null
      staffName: map['staffName'] as String? ?? '',
      table_id: map['table_id'] as int? ?? 0,
      areaName: map['areaName'] as String? ?? '',
      status: map['status'] as String? ?? '',
      totalAmount:
          (map['total_amount'] is int)
              ? map['total_amount'] as int
              : (map['total_amount'] is double)
              ? (map['total_amount'] as double).toInt()
              : 0,
      note: map['note'] as String? ?? '',
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'])
              : DateTime.now(),
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'])
              : DateTime.now(),
    );
  }
}
