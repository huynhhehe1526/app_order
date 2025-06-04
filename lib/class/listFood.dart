// // lib/class/dish.dart
// class Dish {
//   final int? id;
//   final String name;
//   final double price;
//   final String? imageUrl;
//   final int categoryId;
//   final String status;
//   final double rating;
//   final int ratingCount;
//   final String? createdAt;
//   final String? updatedAt;

//   Dish({
//     this.id,
//     required this.name,
//     required this.price,
//     this.imageUrl,
//     required this.categoryId,
//     required this.status,
//     this.rating = 0.0,
//     this.ratingCount = 0,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Dish.fromJson(Map<String, dynamic> json) {
//     return Dish(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'].toDouble(),
//       categoryId: json['category_id'],
//       status: json['status'],
//     );
//   }

//   factory Dish.fromMap(Map<String, dynamic> map) => Dish(
//     id: map['id'],
//     name: map['name'],
//     price: map['price'],
//     imageUrl: map['image_url'],
//     categoryId: map['category_id'],
//     status: map['status'],
//     rating: map['rating'],
//     ratingCount: map['ratingCount'],
//     createdAt: map['created_at'],
//     updatedAt: map['updated_at'],
//   );

//   Map<String, dynamic> toMap() => {
//     'id': id,
//     'name': name,
//     'price': price,
//     'image_url': imageUrl,
//     'category_id': categoryId,
//     'status': status,
//     'rating': rating,
//     'ratingCount': ratingCount,
//     'created_at': DateTime.now().toIso8601String(),
//     'updated_at': DateTime.now().toIso8601String(),
//   };
//   @override
//   String toString() {
//     return 'Dish(id: $id, name: $name, price: $price)';
//   }
// }

//test
// lib/class/dish.dart
class Dish {
  final int? id;
  final String name;
  final double price;
  final String? imageUrl;
  final int categoryId;
  final String status;
  final double rating;
  final int ratingCount;
  int quantity;
  final String? createdAt;
  final String? updatedAt;

  Dish({
    this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    required this.categoryId,
    required this.status,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.quantity = 1, // mặc định là 1
    this.createdAt,
    this.updatedAt,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      categoryId: json['category_id'],
      status: json['status'],
    );
  }

  factory Dish.fromMap(Map<String, dynamic> map) => Dish(
    id: map['id'],
    name: map['name'],
    price: map['price'],
    imageUrl: map['image_url'],
    categoryId: map['category_id'],
    status: map['status'],
    rating: map['rating'],
    ratingCount: map['ratingCount'],
    createdAt: map['created_at'],
    updatedAt: map['updated_at'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'price': price,
    'image_url': imageUrl,
    'category_id': categoryId,
    'status': status,
    'rating': rating,
    'ratingCount': ratingCount,
    'created_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
  };
  @override
  String toString() {
    return 'Dish(id: $id, name: $name, price: $price)';
  }
}
