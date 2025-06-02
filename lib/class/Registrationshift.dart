class Registrationshift {
  final int? id;
  final int shift_id;
  final int? staff_id;
  final int table_id;
  final String shiftName;
  final String startTime;
  final String endTime;
  final String? staffName;
  final String? areaName;
  final String createdAt;
  final String updatedAt;

  Registrationshift({
    this.id,
    required this.shift_id,
    required this.staff_id,
    required this.table_id,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    this.staffName,
    this.areaName,
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

  // factory Registrationshift.fromMap(Map<String, dynamic> map) {
  //   return Registrationshift(
  //     id: map['id'],
  //     shift_id: map['shift_id'],
  //     staff_id: map['staff_id'],
  //     table_id: map['table_id'],
  //     shiftName: map['shiftname'],
  //     startTime: map['start_time'],
  //     endTime: map['end_time'],
  //     staffName: map['staffName'] as String?,
  //     createdAt: map['created_at'],
  //     updatedAt: map['updated_at'],
  //   );
  // }

  factory Registrationshift.fromMap(Map<String, dynamic> map) {
    return Registrationshift(
      id: map['id'],
      shift_id: map['shift_id'],
      staff_id: map['staff_id'] as int?,
      table_id: map['table_id'],
      shiftName: map['shiftname'] ?? 'Không rõ',
      startTime: map['start_time'] ?? '00:00',
      endTime: map['end_time'] ?? '00:00',
      staffName: map['staffName'],
      areaName: map['areaName'],
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }
}
