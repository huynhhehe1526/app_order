import 'package:dt02_nhom09/class/listFood.dart';

class OrderItem {
  final Dish dish;
  int quantity;

  OrderItem({required this.dish, required this.quantity});

  Map<String, dynamic> toMap() => {'dish_id': dish.id, 'quantity': quantity};
}
