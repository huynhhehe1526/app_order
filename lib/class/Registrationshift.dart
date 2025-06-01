class Registrationshift {
  final int? id;
  final int shift_id;
  final int staff_id;
  final int table_id;
  final String createdAt;
  final String updatedAt;

  Registrationshift({
    this.id,
    required this.shift_id,
    required this.staff_id,
    required this.table_id,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shift_id': shift_id,
      'staff_id': staff_id,
      'table_id': table_id,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Registrationshift.fromMap(Map<String, dynamic> map) {
    return Registrationshift(
      id: map['id'],
      shift_id: map['shift_id'],
      staff_id: map['staff_id'],
      table_id: map['table_id'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
