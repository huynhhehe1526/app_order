class User {
  final int? id;
  final String username;
  final String password;
  final String fullname;
  final String role;
  final String phone;
  final String email;
  final String address;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.fullname,
    required this.role,
    required this.phone,
    required this.email,
    required this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      fullname: map['fullname'] ?? '',
      role: map['role'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'fullname': fullname,
      'role': role,
      'phone': phone,
      'email': email,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  User copyWith({
    String? fullname,
    String? email,
    String? phone,
    String? address,
  }) {
    return User(
      id: id,
      username: username,
      password: password,
      fullname: fullname ?? this.fullname,
      role: role,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
