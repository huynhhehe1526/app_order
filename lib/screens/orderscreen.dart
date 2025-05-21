import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<FoodItem> foodList = [
    FoodItem(
      id: 1,
      name: 'Trà sữa',
      price: 30000,
      image: 'assets/images/che_duong_nhan.jpg',
    ),
    FoodItem(
      id: 2,
      name: 'Cà phê sữa',
      price: 25000,
      image: 'assets/images/sinh_to_bo.webp',
    ),
    FoodItem(
      id: 3,
      name: 'Bánh mì',
      price: 20000,
      image: 'assets/images/nuoc_ep_dua.jpg',
    ),
  ];

  List<FoodItem> get cart =>
      foodList.where((item) => item.quantity > 0).toList();

  int get totalPrice =>
      cart.fold(0, (sum, item) => sum + item.price * item.quantity);

  void increaseQuantity(FoodItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void decreaseQuantity(FoodItem item) {
    setState(() {
      if (item.quantity > 0) item.quantity--;
    });
  }

  void sendOrder() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Chưa chọn món nào!')));
      return;
    }
    print("Đơn hàng đã gửi:");
    for (var item in cart) {
      print("${item.name} x${item.quantity}");
    }
    print("Tổng tiền: $totalPrice đ");

    // Reset sau khi gửi
    setState(() {
      for (var item in foodList) {
        item.quantity = 0;
      }
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Đã gửi đơn thành công')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đặt món')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: foodList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 món mỗi hàng
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final item = foodList[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(item.image, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          item.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text('${item.price}đ'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => decreaseQuantity(item),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => increaseQuantity(item),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tổng tiền: $totalPrice đ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: sendOrder,
                  child: const Text('Gửi đơn đến bếp'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
