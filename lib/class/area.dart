class Area {
  final int? id;
  final String name;

  Area({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
}

  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(id: map['id'], name: map['name']);
  }
}
