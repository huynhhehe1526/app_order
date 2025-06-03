// // //test
// import 'package:dt02_nhom09/db/db_helper.dart';
// import 'package:flutter/material.dart';
// import './order_mode.dart';
// import 'package:dt02_nhom09/screens/data/mock_data.dart';
// // import 'package:dt02_nhom09/class/order_model.dart';

// class OrderScreen extends StatefulWidget {
//   final int id;
//   final String name;
//   final String role;
//   const OrderScreen({
//     super.key,
//     required this.role,
//     required this.id,
//     required this.name,
//   });
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   /// Trả về list đơn hàng với cấu trúc lồng:
//   /// {id, customer, staff, status, note, total, details:[{dish, quantity, status, chef}]}
//   // List<Map<String, dynamic>> buildDisplayOrders() {
//   //   // helper – tra tên user
//   //   String? userName(int id) =>
//   //       users.firstWhere((u) => u['id'] == id, orElse: () => {})['fullname'];

//   //   // helper – tra tên món
//   //   String? dishName(int id) =>
//   //       dishes.firstWhere((d) => d['id'] == id, orElse: () => {})['name'];

//   //   return orders.map((o) {
//   //     final details =
//   //         orderDetails
//   //             .where((d) => d['order_id'] == o['id'])
//   //             .map(
//   //               (d) => {
//   //                 'dish': dishName(d['dish_id']),
//   //                 'quantity': int.parse(d['quantity']),
//   //                 'status': d['status'],
//   //                 'chef': userName(d['chef_id']),
//   //               },
//   //             )
//   //             .toList();

//   //     return {
//   //       'id': o['id'],
//   //       'customer': userName(o['customer_id']),
//   //       'staff': userName(o['staff_id']),
//   //       'status': o['status'],
//   //       'note': o['note'],
//   //       'total': int.parse(o['total_amount']),
//   //       'details': details,
//   //     };
//   //   }).toList();
//   // }

//   List<Map<String, dynamic>> buildDisplayOrders() {
//     // helper – tra tên user
//     String? userName(int id) =>
//         users.firstWhere((u) => u['id'] == id, orElse: () => {})['fullname'];
//     // helper – tra tên món
//     String? dishName(int id) =>
//         dishes.firstWhere((d) => d['id'] == id, orElse: () => {})['name'];

//     // Lọc orders theo role và userId
//     Iterable<Map<String, dynamic>> filteredOrders;

//     if (widget.role == "Quản lý") {
//       // Quản lý xem tất cả
//       filteredOrders = orders;
//     } else if (widget.role == "Nhân viên phục vụ") {
//       // Phục vụ xem order mà staff_id là userId
//       filteredOrders = orders.where((o) => o['staff_id'] == widget.id);
//     } else if (widget.role == "Khách") {
//       // Khách hàng xem order mà customer_id là userId
//       filteredOrders = orders.where((o) => o['customer_id'] == widget.id);
//     } else {
//       // Nếu role khác thì không show order nào (hoặc có thể show rỗng)
//       filteredOrders = [];
//     }
//     return filteredOrders.map((o) {
//       final details =
//           orderDetails
//               .where((d) => d['order_id'] == o['id'])
//               .map(
//                 (d) => {
//                   'dish': dishName(d['dish_id']),
//                   'quantity': int.parse(d['quantity']),
//                   'status': d['status'],
//                   'chef': userName(d['chef_id']),
//                 },
//               )
//               .toList();

//       return {
//         'id': o['id'],
//         'customer': userName(o['customer_id']),
//         'staff': userName(o['staff_id']),
//         'status': o['status'],
//         'note': o['note'],
//         'total': int.parse(o['total_amount']),
//         'details': details,
//       };
//     }).toList();
//   }

//   late List<Map<String, dynamic>> displayOrders;

//   @override
//   void initState() {
//     super.initState();
//     // Lấy dữ liệu hiển thị từ mock_data thông qua hàm join
//     displayOrders = buildDisplayOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if ((widget.role == "Khách" || widget.role == "Phục vụ") &&
//         displayOrders.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(title: Text("Danh sách đơn hàng")),
//         body: Center(
//           child: Text(
//             "Chưa có đơn nào",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             // Xác định mode theo role

//             OrderMode mode;
//             if (widget.role == "Khách") {
//               mode = OrderMode.customerOnline;
//             } else {
//               mode = OrderMode.staffWalkIn;
//             }

//             // final newOrder = await Navigator.pushNamed(
//             //   context,
//             //   '/add_order',
//             //   arguments: {'mode': mode},
//             // );
//             final newOrder = await Navigator.pushNamed(
//               context,
//               '/add_order',
//               arguments: {
//                 'mode':
//                     widget.role == 'Khách'
//                         ? OrderMode.customerOnline
//                         : OrderMode.staffWalkIn,
//                 'name': widget.name,
//                 'role': widget.role,
//               },
//             );

//             if (newOrder != null && newOrder is Map<String, dynamic>) {
//               setState(() {
//                 final newId =
//                     displayOrders.isNotEmpty
//                         ? (displayOrders.last['id'] as int) + 1
//                         : 1;
//                 newOrder['id'] = newId;

//                 if (newOrder['details'] == null ||
//                     newOrder['details'] is! List) {
//                   newOrder['details'] = [];
//                 }

//                 displayOrders.add(newOrder);
//               });
//             }
//           },
//           tooltip: "Thêm đơn hàng",
//           child: const Icon(Icons.add),
//         ),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(title: Text("Danh sách đơn hàng")),
//       body: ListView.builder(
//         itemCount: displayOrders.length,
//         itemBuilder: (context, index) {
//           final order = displayOrders[index];
//           return Card(
//             margin: EdgeInsets.all(10),
//             child: ExpansionTile(
//               title: Text("Đơn #${order['id']} - ${order['customer']}"),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Nhân viên: ${order['staff']}"),
//                   Text("Trạng thái: ${order['status']}"),
//                   Text("Tổng: ${order['total']}đ"),
//                 ],
//               ),
//               children: [
//                 // ...order['details'].map<Widget>(
//                 //   (item) => ListTile(
//                 //     title: Text("${item['dish']} x${item['quantity']}"),
//                 //     subtitle: Text("Trạng thái: ${item['status']}"),
//                 //     trailing:
//                 //         item['chef'] != null
//                 //             ? Text("👨‍🍳 ${item['chef']}")
//                 //             : null,
//                 //   ),
//                 // ),
//                 ...order['details'].map<Widget>((item) {
//                   final dishName = item['dish'] ?? "Không xác định";
//                   final quantity = item['quantity'] ?? 0;
//                   final status = item['status'] ?? "Chưa có trạng thái";
//                   final chef = item['chef'];

//                   return ListTile(
//                     title: Text("$dishName x$quantity"),
//                     subtitle: Text("Trạng thái: $status"),
//                     trailing: chef != null ? Text("👨‍🍳 $chef") : null,
//                   );
//                 }).toList(),

//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Ghi chú: ${order['note']}"),
//                 ),
//                 OverflowBar(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         // cập nhật trạng thái hoặc xử lý gì đó
//                       },
//                       child: Text("Cập nhật"),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(
//                           context,
//                           '/order_detail',
//                           arguments: order,
//                         );
//                       },
//                       child: Text("Xem chi tiết"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),

//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () async {
//       //     // Mở màn hình thêm order
//       //     final newOrder = await Navigator.pushNamed(context, '/add_order');
//       //     if (newOrder != null) {
//       //       setState(() {
//       //         mockOrders.add(newOrder as Map<String, dynamic>);
//       //       });
//       //     }
//       //   },
//       //   tooltip: "Thêm đơn hàng",
//       //   child: Icon(Icons.add),
//       // ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () async {
//       //     final newOrder = await Navigator.pushNamed(context, '/add_order');
//       //     if (newOrder != null && newOrder is Map<String, dynamic>) {
//       //       setState(() {
//       //         // Gán id mới
//       //         final newId =
//       //             mockOrders.isNotEmpty
//       //                 ? (mockOrders.last['id'] as int) + 1
//       //                 : 1;
//       //         newOrder['id'] = newId;

//       //         // Kiểm tra dữ liệu details có tồn tại và đúng kiểu không
//       //         if (newOrder['details'] == null || newOrder['details'] is! List) {
//       //           newOrder['details'] = [];
//       //         }

//       //         mockOrders.add(newOrder);
//       //       });
//       //     }
//       //   },
//       //   tooltip: "Thêm đơn hàng",
//       //   child: Icon(Icons.add),
//       // ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Xác định mode theo role

//           OrderMode mode;
//           if (widget.role == "Khách") {
//             mode = OrderMode.customerOnline;
//           } else {
//             mode = OrderMode.staffWalkIn;
//           }

//           // final newOrder = await Navigator.pushNamed(
//           //   context,
//           //   '/add_order',
//           //   arguments: {'mode': mode},
//           // );
//           final newOrder = await Navigator.pushNamed(
//             context,
//             '/add_order',
//             arguments: {
//               'mode':
//                   widget.role == 'Khách'
//                       ? OrderMode.customerOnline
//                       : OrderMode.staffWalkIn,
//               'name': widget.name,
//               'role': widget.role,
//             },
//           );

//           if (newOrder != null && newOrder is Map<String, dynamic>) {
//             setState(() {
//               final newId =
//                   displayOrders.isNotEmpty
//                       ? (displayOrders.last['id'] as int) + 1
//                       : 1;
//               newOrder['id'] = newId;

//               if (newOrder['details'] == null || newOrder['details'] is! List) {
//                 newOrder['details'] = [];
//               }

//               displayOrders.add(newOrder);
//             });
//           }
//         },
//         tooltip: "Thêm đơn hàng",
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

//test
//test
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:dt02_nhom09/screens/modalCrud/addOrderScreen.dart';
import 'package:flutter/material.dart';
import './order_mode.dart';
import 'package:dt02_nhom09/screens/data/mock_data.dart';
// import 'package:dt02_nhom09/class/order_model.dart';

class OrderScreen extends StatefulWidget {
  final int id;
  final String name;
  final String role;
  const OrderScreen({
    super.key,
    required this.role,
    required this.id,
    required this.name,
  });
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  DatabaseHelper db = DatabaseHelper();

  List<Map<String, dynamic>> displayOrders = [];
  List<Map<String, dynamic>> orderDetails = [];
  List<Map<String, dynamic>> users = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Lấy list orders từ DB qua hàm getOrderWithUserInfo()
      List<Map<String, dynamic>> ordersFromDb = await db.getOrderWithUserInfo();

      // Nếu bạn có hàm lấy chi tiết đơn hàng, cũng load tương tự
      // For example:
      // orderDetails = await db.getOrderDetails();

      // Lọc orders theo role và userId như trước
      Iterable<Map<String, dynamic>> filteredOrders;

      if (widget.role == "Quản lý") {
        filteredOrders = ordersFromDb;
      } else if (widget.role == "Nhân viên") {
        filteredOrders = ordersFromDb.where((o) => o['staff_id'] == widget.id);
      } else if (widget.role == "Khách") {
        filteredOrders = ordersFromDb.where(
          (o) => o['customer_id'] == widget.id,
        );
      } else {
        filteredOrders = [];
      }

      // Chuyển đổi sang dạng dữ liệu cần hiển thị (thêm details nếu có)
      displayOrders =
          filteredOrders.map((o) {
            // Lấy chi tiết order của order này từ orderDetails
            final details =
                orderDetails
                    .where((d) => d['order_id'] == o['id'])
                    .map(
                      (d) => {
                        'dish':
                            d['dish_name'] ??
                            "Không xác định", // thay đổi theo DB bạn
                        'quantity': d['quantity'],
                        'status': d['status'],
                        'chef': d['chef_name'],
                      },
                    )
                    .toList();

            return {
              'id': o['id'],
              'customer': o['customerName'] ?? "Không xác định",
              'staff': o['staffName'] ?? "Không xác định",
              'status': o['status'],
              'note': o['note'],
              'total': o['total_amount'],
              'details': details,
            };
          }).toList();
    } catch (e) {
      print("Error loading orders: $e");
      displayOrders = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Danh sách đơn hàng")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if ((widget.role == "Khách" || widget.role == "Nhân viên phục vụ") &&
        displayOrders.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Danh sách đơn hàng")),
        body: Center(
          child: Text(
            "Chưa có đơn nào",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     // Xử lý thêm đơn mới, tương tự như bạn làm
        //   },
        //   tooltip: "Thêm đơn hàng",
        //   child: const Icon(Icons.add),
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Xác định mode theo role

            OrderMode mode;
            if (widget.role == "Khách") {
              mode = OrderMode.customerOnline;
            } else {
              mode = OrderMode.staffWalkIn;
            }

            // final newOrder = await Navigator.pushNamed(
            //   context,
            //   '/add_order',
            //   arguments: {'mode': mode},
            // );
            final newOrder = await Navigator.pushNamed(
              context,
              '/add_order',
              arguments: {
                'mode':
                    widget.role == 'Khách'
                        ? OrderMode.customerOnline
                        : OrderMode.staffWalkIn,
                'id': widget.id,
                'name': widget.name,
                'role': widget.role,
              },
            );

            if (newOrder != null && newOrder is Map<String, dynamic>) {
              setState(() {
                final newId =
                    displayOrders.isNotEmpty
                        ? (displayOrders.last['id'] as int) + 1
                        : 1;
                newOrder['id'] = newId;

                if (newOrder['details'] == null ||
                    newOrder['details'] is! List) {
                  newOrder['details'] = [];
                }

                displayOrders.add(newOrder);
              });
            }
          },
          tooltip: "Thêm đơn hàng",
          child: const Icon(Icons.add),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Danh sách đơn hàng")),
      body: ListView.builder(
        itemCount: displayOrders.length,
        itemBuilder: (context, index) {
          final order = displayOrders[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ExpansionTile(
              title: Text("Đơn #${order['id']} - ${order['customer']}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nhân viên: ${order['staff']}"),
                  Text("Trạng thái: ${order['status']}"),
                  Text("Tổng: ${order['total']}đ"),
                ],
              ),
              children: [
                ...order['details'].map<Widget>((item) {
                  final dishName = item['dish'] ?? "Không xác định";
                  final quantity = item['quantity'] ?? 0;
                  final status = item['status'] ?? "Chưa có trạng thái";
                  final chef = item['chef'];

                  return ListTile(
                    title: Text("$dishName x$quantity"),
                    subtitle: Text("Trạng thái: $status"),
                    trailing: chef != null ? Text("👨‍🍳 $chef") : null,
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Ghi chú: ${order['note']}"),
                ),
                OverflowBar(
                  children: [
                    TextButton(
                      onPressed: () {
                        // cập nhật trạng thái hoặc xử lý gì đó
                      },
                      child: Text("Cập nhật"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/order_detail',
                          arguments: order,
                        );
                      },
                      child: Text("Xem chi tiết"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // Xác định mode theo role và thêm order mới
      //   },
      //   tooltip: "Thêm đơn hàng",
      //   child: const Icon(Icons.add),
      // ),

      //ngon

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // Xác định mode theo role

      //     OrderMode mode;
      //     if (widget.role == "Khách") {
      //       mode = OrderMode.customerOnline;
      //     } else {
      //       mode = OrderMode.staffWalkIn;
      //     }

      //     // final newOrder = await Navigator.pushNamed(
      //     //   context,
      //     //   '/add_order',
      //     //   arguments: {'mode': mode},
      //     // );
      //     final newOrder = await Navigator.pushNamed(
      //       context,
      //       '/add_order',
      //       arguments: {
      //         'mode':
      //             widget.role == 'Khách'
      //                 ? OrderMode.customerOnline
      //                 : OrderMode.staffWalkIn,
      //         'name': widget.name,
      //         'role': widget.role,
      //       },
      //     );

      //     if (newOrder != null && newOrder is Map<String, dynamic>) {
      //       setState(() {
      //         final newId =
      //             displayOrders.isNotEmpty
      //                 ? (displayOrders.last['id'] as int) + 1
      //                 : 1;
      //         newOrder['id'] = newId;

      //         if (newOrder['details'] == null || newOrder['details'] is! List) {
      //           newOrder['details'] = [];
      //         }

      //         displayOrders.add(newOrder);
      //       });
      //     }
      //   },
      //   tooltip: "Thêm đơn hàng",
      //   child: const Icon(Icons.add),
      // ),

      //test
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Hiển thị dialog hiện tên và role
          final proceed = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Thông tin người dùng'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tên: ${widget.name}'),
                    SizedBox(height: 8),
                    Text('Vai trò: ${widget.role}'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pop(false);
                    },
                    child: Text('Hủy'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );

          if (proceed == true) {
            // Nếu người dùng OK, chuyển màn thêm đơn hàng
            OrderMode mode;
            if (widget.role == "Khách") {
              mode = OrderMode.customerOnline;
            } else {
              mode = OrderMode.staffWalkIn;
            }

            // final newOrder = await Navigator.pushNamed(
            //   context,
            //   '/add_order',
            //   arguments: {
            //     'mode': mode,
            //     'name': widget.name,
            //     'role': widget.role,
            //   },
            // );

            print("OrderScreen: name = ${widget.name}");
            final newOrder = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => AddOrderScreen(
                      mode: mode,
                      id: widget.id,
                      role: widget.role,
                      name: widget.name,
                    ),
              ),
            );

            if (newOrder != null && newOrder is Map<String, dynamic>) {
              setState(() {
                final newId =
                    displayOrders.isNotEmpty
                        ? (displayOrders.last['id'] as int) + 1
                        : 1;
                newOrder['id'] = newId;

                if (newOrder['details'] == null ||
                    newOrder['details'] is! List) {
                  newOrder['details'] = [];
                }

                displayOrders.add(newOrder);
              });
            }
          }
        },
        tooltip: "Thêm đơn hàng",
        child: const Icon(Icons.add),
      ),
    );
  }
}
