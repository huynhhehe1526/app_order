// class TableModel {
//   final int? id;
//   final int seatCount;
//   final String status;
//   final double price;
//   final int areaId;
//   final String createdAt;
//   final String updatedAt;

//   TableModel({
//     this.id,
//     required this.seatCount,
//     required this.status,
//     required this.price,
//     required this.areaId,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'seat_count': seatCount,
//       'status': status,
//       'price': price,
//       'areaId': areaId,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }

//   factory TableModel.fromMap(Map<String, dynamic> map) {
//     return TableModel(
//       id: map['id'],
//       seatCount: map['seat_count'],
//       status: map['status'],
//       price: map['price'] != null ? (map['price'] as num).toDouble() : 0.0,
//       areaId: map['areaId'],
//       createdAt: map['created_at'],
//       updatedAt: map['updated_at'],
//     );
//   }
// }

class TableModel {
  final int? id;
  final int seatCount;
  final String status;
  final double price;
  final int areaId; // giữ nguyên tên thuộc tính
  final String createdAt;
  final String updatedAt;
  final String? areaName; // tiện lợi cho JOIN

  TableModel({
    this.id,
    required this.seatCount,
    required this.status,
    required this.price,
    required this.areaId,
    required this.createdAt,
    required this.updatedAt,
    this.areaName,
  });

  /// Dùng khi KHÔNG JOIN với Areas
  factory TableModel.fromMap(Map<String, dynamic> map) => TableModel(
    id: map['id'] as int,
    seatCount: map['seat_count'] as int,
    status: map['status'] as String,
    price: (map['price'] as num).toDouble(),
    areaId: map['area_id'] as int, // ⚠️ sửa lại key
    createdAt: map['created_at'] as String,
    updatedAt: map['updated_at'] as String,
  );

  /// Dùng khi JOIN để lấy thêm area_name
  factory TableModel.fromJoinedMap(Map<String, dynamic> map) => TableModel(
    id: map['id'] as int,
    seatCount: map['seat_count'] as int,
    status: map['status'] as String,
    price: (map['price'] as num).toDouble(),
    areaId: map['area_id'] as int,
    areaName: map['area_name'] as String?,
    createdAt: map['created_at'] as String,
    updatedAt: map['updated_at'] as String,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'seat_count': seatCount,
    'status': status,
    'price': price,
    'area_id': areaId, // ⚠️ sửa lại key
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
