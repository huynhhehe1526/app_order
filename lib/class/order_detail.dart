class OrderDetail {
  int? id;
  int? orderId;
  int? dishId;
  int? quantity;
  String? status;
  int? chefId;
  String? createdAt;
  String? updatedAt;

  OrderDetail({
    this.id,
    this.orderId,
    this.dishId,
    this.quantity,
    this.status,
    this.chefId,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'] as int?,
      orderId: map['order_id'] as int?,
      dishId: map['dish_id'] as int?,
      quantity: map['quantity'] as int?,
      status: map['status'] as String?,
      chefId: map['chef_id'] as int?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // if (id != null) 'id': id,
      'order_id': orderId,
      'dish_id': dishId,
      'quantity': quantity,
      'status': status,
      'chef_id': chefId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
