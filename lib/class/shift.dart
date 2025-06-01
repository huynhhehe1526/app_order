class Shift {
  final int? id;
  final String shiftname; // ca sáng, chiều, tối
  final String startTime;
  final String endTime;
  final String createdAt;
  final String updatedAt;

  Shift({
    this.id,
    required this.shiftname,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shiftname': shiftname,
      'start_time': startTime,
      'end_time': endTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Shift.fromMap(Map<String, dynamic> map) {
    return Shift(
      id: map['id'],
      shiftname: map['shiftname'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}