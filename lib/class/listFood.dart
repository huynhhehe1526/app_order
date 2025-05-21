class FoodItem {
  final int id;
  final String name;
  final int price;
  final String image;
  int quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 0,
  });
}
