// // import 'package:dt02_nhom09/class/categories.dart';
// // import 'package:dt02_nhom09/screens/home.dart';
// // import 'package:dt02_nhom09/screens/modalCrud/addMenu.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class MenuScreen extends StatelessWidget {
// //   final List<Category> listCategory = [];
// //   final List<Map<String, dynamic>> menuItems = [
// //     {
// //       'name': 'Phở Bò',
// //       'price': 50000,
// //       'image': 'assets/images/pho_bo.jpg',
// //       'type': 'Món ăn chính',
// //     },
// //     {
// //       'name': 'Cà phê Sữa',
// //       'price': 30000,
// //       'image': 'assets/images/cafe_sua.webp',
// //       'type': 'Đồ uống',
// //     },
// //     {
// //       'name': 'Bánh Flan',
// //       'price': 25000,
// //       'image': 'assets/images/banh_flan.jpg',
// //       'type': 'Món tráng miệng',
// //     },
// //     {
// //       'name': 'Bún Bò',
// //       'price': 55000,
// //       'image': 'assets/images/bun_bo.jpg',
// //       'type': 'Món ăn chính',
// //     },
// //     {
// //       'name': 'Trà Đào',
// //       'price': 35000,
// //       'image': 'assets/images/tra_dao.jpg',
// //       'type': 'Đồ uống',
// //     },
// //     {
// //       'name': 'Kem Dừa',
// //       'price': 30000,
// //       'image': 'assets/images/kem_dua.jpg',
// //       'type': 'Món tráng miệng',
// //     },
// //     {
// //       'name': 'Cơm Gà',
// //       'price': 60000,
// //       'image': 'assets/images/com_ga.jpg',
// //       'type': 'Món ăn chính',
// //     },
// //     {
// //       'name': 'Sinh Tố Bơ',
// //       'price': 40000,
// //       'image': 'assets/images/sinh_to_bo.webp',
// //       'type': 'Đồ uống',
// //     },
// //     {
// //       'name': 'Cheese Cake',
// //       'price': 45000,
// //       'image': 'assets/images/cheese_cake.jpg',
// //       'type': 'Món tráng miệng',
// //     },
// //     {
// //       'name': 'Mì Quảng',
// //       'price': 55000,
// //       'image': 'assets/images/mi_quang_ga.png',
// //       'type': 'Món ăn chính',
// //     },
// //     {
// //       'name': 'Nước Ép Cam',
// //       'price': 30000,
// //       'image': 'assets/images/nuoc_ep_cam.jpg',
// //       'type': 'Đồ uống',
// //     },
// //     {
// //       'name': 'Chè Dưỡng Nhan',
// //       'price': 20000,
// //       'image': 'assets/images/che_duong_nhan.jpg',
// //       'type': 'Món tráng miệng',
// //     },
// //     {
// //       'name': 'Soda Chanh',
// //       'price': 25000,
// //       'image': 'assets/images/so_da_chanh.webp',
// //       'type': 'Đồ uống',
// //     },
// //     {
// //       'name': 'Bánh Hạt Dẻ',
// //       'price': 30000,
// //       'image': 'assets/images/banh_hat_de.jpg',
// //       'type': 'Món tráng miệng',
// //     },
// //     {
// //       'name': 'Nước Ép Dưa Hấu',
// //       'price': 30000,
// //       'image': 'assets/images/nuoc_ep_dua_hau.jpg',
// //       'type': 'Đồ uống',
// //     },
// //     {
// //       'name': 'Chè Thái',
// //       'price': 35000,
// //       'image': 'assets/images/che_thai.jpg',
// //       'type': 'Món tráng miệng',
// //     },
// //     {
// //       'name': 'Bánh Tráng Trộn',
// //       'price': 25000,
// //       'image': 'assets/images/banh_trang_tron.jpg',
// //       'type': 'Món tráng miệng',
// //     },
// //   ];

// //   MenuScreen({super.key});

// //   //  @override
// //   // void initState() {
// //   //   super.initState();
// //   //   _loadUsers();
// //   // }

// //   // void loadCategories() {
// //   //   setState(() {
// //   //     _usersFuture = dbHelper.getAllUsers().then((users) {
// //   //       _allUsers = users;
// //   //       _applyFilters();
// //   //       return users;
// //   //     });
// //   //   });
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Thực đơn'),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed:
// //               // () => Navigator.pushReplacement(
// //               //   context,
// //               //   MaterialPageRoute(builder: (context) => HomeScreen()),
// //               // ),
// //               () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: SingleChildScrollView(
// //               scrollDirection: Axis.horizontal,
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   ElevatedButton.icon(
// //                     onPressed: () {},
// //                     icon: Icon(Icons.sort),
// //                     label: Text('Sắp xếp'),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.grey[200],
// //                       foregroundColor: Colors.black,
// //                     ),
// //                   ),
// //                   SizedBox(width: 8),
// //                   ElevatedButton.icon(
// //                     onPressed: () {},
// //                     icon: Icon(Icons.category),
// //                     label: Text('Dịch vụ'),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.grey[200],
// //                       foregroundColor: Colors.black,
// //                     ),
// //                   ),
// //                   SizedBox(width: 8),
// //                   ElevatedButton.icon(
// //                     onPressed: () {},
// //                     icon: Icon(Icons.location_on),
// //                     label: Text('Gần tôi'),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.grey[200],
// //                       foregroundColor: Colors.black,
// //                     ),
// //                   ),
// //                   SizedBox(width: 8),
// //                   ElevatedButton.icon(
// //                     onPressed: () {},
// //                     icon: Icon(Icons.star),
// //                     label: Text('Yêu thích'),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.grey[200],
// //                       foregroundColor: Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: SizedBox(
// //               height: 90, // Chiều cao của GridView
// //               child: GridView.count(
// //                 crossAxisCount: 2, // Hai cột trong GridView
// //                 mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
// //                 crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
// //                 childAspectRatio: 2,
// //                 children: [
// //                   //khung A
// //                   Card(
// //                     elevation: 4.0,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20),
// //                       side: BorderSide(color: Colors.orange),
// //                     ),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           crossAxisAlignment: CrossAxisAlignment.center,
// //                           children: [
// //                             Container(
// //                               width: 50,
// //                               height: 60,
// //                               decoration: BoxDecoration(
// //                                 color: Colors.orange.shade100,
// //                                 borderRadius: BorderRadius.only(
// //                                   topRight: Radius.circular(30),
// //                                   bottomRight: Radius.circular(30),
// //                                   topLeft: Radius.circular(20),
// //                                   bottomLeft: Radius.circular(20),
// //                                 ),
// //                               ),
// //                               child: Center(
// //                                 child: SvgPicture.asset(
// //                                   'assets/icons/gift-svgrepo-com.svg',
// //                                   fit: BoxFit.cover,
// //                                 ),
// //                               ),
// //                             ),
// //                             Expanded(
// //                               child: Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Text(
// //                                       'Đang có',
// //                                       style: TextStyle(fontSize: 14),
// //                                     ),
// //                                     SizedBox(height: 4),
// //                                     Text(
// //                                       'khuyến mãi',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 12,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               width: 40,
// //                               height: 40,
// //                               child: Center(
// //                                 child: Icon(
// //                                   Icons.arrow_forward,
// //                                   color: Colors.orange,
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   //khung B
// //                   Card(
// //                     elevation: 4.0,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20),
// //                       side: BorderSide(color: Colors.blue),
// //                     ),
// //                     color: const Color.fromARGB(255, 10, 24, 178),
// //                     //color: Colors.blue.shade800,
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           crossAxisAlignment: CrossAxisAlignment.center,
// //                           children: [
// //                             Container(
// //                               width: 55,
// //                               height: 60,
// //                               decoration: BoxDecoration(
// //                                 //color: const Color.fromARGB(255, 10, 24, 178),
// //                                 color: Colors.blue.shade800,
// //                                 borderRadius: BorderRadius.only(
// //                                   topRight: Radius.circular(30),
// //                                   bottomRight: Radius.circular(30),
// //                                   topLeft: Radius.circular(20),
// //                                   bottomLeft: Radius.circular(20),
// //                                 ),
// //                               ),
// //                               child: Center(
// //                                 child: SvgPicture.asset(
// //                                   'assets/icons/order-food-svgrepo-com.svg',
// //                                   fit: BoxFit.cover,
// //                                 ),
// //                               ),
// //                             ),
// //                             Expanded(
// //                               child: Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Text(
// //                                       'Đặt món ngay',
// //                                       style: TextStyle(
// //                                         fontSize: 12,
// //                                         color: Colors.white,
// //                                       ),
// //                                     ),
// //                                     SizedBox(height: 4),
// //                                     Text(
// //                                       '4 hộp quà',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 12,
// //                                         color: Colors.white,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                             Container(
// //                               width: 30,
// //                               height: 30,
// //                               decoration: BoxDecoration(
// //                                 color: Colors.white,
// //                                 shape: BoxShape.circle,
// //                               ),
// //                               child: Center(
// //                                 child: Icon(
// //                                   Icons.arrow_forward,
// //                                   color: Colors.blue,
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: SingleChildScrollView(
// //               child: Column(children: _buildMenuList()),
// //             ),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => AddMenuScreen()),
// //           );
// //         },
// //         tooltip: "Thêm đơn hàng",
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }

// //   List<Widget> _buildMenuList() {
// //     Map<String, List<Map<String, dynamic>>> groupedMenu = {};
// //     for (var item in menuItems) {
// //       if (!groupedMenu.containsKey(item['type'])) {
// //         groupedMenu[item['type']] = [];
// //       }
// //       groupedMenu[item['type']]!.add(item);
// //     }

// //     List<Widget> menuWidgets = [];
// //     groupedMenu.forEach((type, items) {
// //       // menuWidgets.add(
// //       //   Padding(
// //       //     padding: const EdgeInsets.all(8.0),
// //       //     child: Text(
// //       //       type,
// //       //       style: TextStyle(
// //       //         fontSize: 24,
// //       //         fontWeight: FontWeight.bold,
// //       //         color: Colors.brown,
// //       //       ),

// //       //     ),

// //       //   ),
// //       // );
// //       menuWidgets.add(
// //         Row(
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Text(
// //                 type,
// //                 style: GoogleFonts.grenze(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.brown,
// //                 ),
// //               ),
// //             ),
// //             //  Expanded(child: Divider(color: Colors.grey, thickness: 0.25)),
// //           ],
// //         ),
// //       );
// //       for (var item in items) {
// //         menuWidgets.add(
// //           Card(
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(12.0),
// //             ),
// //             margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// //             color: Colors.brown[50],
// //             elevation: 5,
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   //colors: [Color(0xFFC31432), Color.fromARGB(255, 54, 14, 83)],
// //                   colors: [Color.fromARGB(255, 54, 14, 83), Color(0xFFC31432)],
// //                   begin: Alignment.centerLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //                 borderRadius: BorderRadius.circular(12.0),
// //               ),
// //               child: ListTile(
// //                 leading: ClipRRect(
// //                   borderRadius: BorderRadius.circular(12.0),
// //                   // child: Image.network(
// //                   //   'https://baothainguyen.vn/file/e7837c027f6ecd14017ffa4e5f2a0e34/032024/picture1_20240315162010.png',
// //                   child: Image.asset(
// //                     item['image'],
// //                     width: 80,
// //                     height: 100,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //                 title: Text(
// //                   item['name'],
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 subtitle: SizedBox(
// //                   width: 100,
// //                   child: Text(
// //                     item['type'],
// //                     style: TextStyle(color: Colors.white60),
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                 ),
// //                 trailing: Text(
// //                   'Giá: ${item['price']} VND',
// //                   style: TextStyle(
// //                     color: Colors.yellow,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         );
// //       }
// //     });
// //     return menuWidgets;
// //   }
// // }

// //test function and state
// import 'package:dt02_nhom09/class/categories.dart';
// import 'package:dt02_nhom09/db/db_helper.dart';
// import 'package:dt02_nhom09/screens/home.dart';
// import 'package:dt02_nhom09/screens/modalCrud/addMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({super.key});

//   @override
//   _MenuScreenState createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   List<Category> listCategory = [];
//   DatabaseHelper dbhelper = DatabaseHelper();
//   final List<Map<String, dynamic>> menuItems = [
//     {
//       'name': 'Phở Bò',
//       'price': 50000,
//       'image': 'assets/images/pho_bo.jpg',
//       'type': 'Món ăn chính',
//     },
//     {
//       'name': 'Cà phê Sữa',
//       'price': 30000,
//       'image': 'assets/images/cafe_sua.webp',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Bánh Flan',
//       'price': 25000,
//       'image': 'assets/images/banh_flan.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Bún Bò',
//       'price': 55000,
//       'image': 'assets/images/bun_bo.jpg',
//       'type': 'Món ăn chính',
//     },
//     {
//       'name': 'Trà Đào',
//       'price': 35000,
//       'image': 'assets/images/tra_dao.jpg',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Kem Dừa',
//       'price': 30000,
//       'image': 'assets/images/kem_dua.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Cơm Gà',
//       'price': 60000,
//       'image': 'assets/images/com_ga.jpg',
//       'type': 'Món ăn chính',
//     },
//     {
//       'name': 'Sinh Tố Bơ',
//       'price': 40000,
//       'image': 'assets/images/sinh_to_bo.webp',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Cheese Cake',
//       'price': 45000,
//       'image': 'assets/images/cheese_cake.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Mì Quảng',
//       'price': 55000,
//       'image': 'assets/images/mi_quang_ga.png',
//       'type': 'Món ăn chính',
//     },
//     {
//       'name': 'Nước Ép Cam',
//       'price': 30000,
//       'image': 'assets/images/nuoc_ep_cam.jpg',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Chè Dưỡng Nhan',
//       'price': 20000,
//       'image': 'assets/images/che_duong_nhan.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Soda Chanh',
//       'price': 25000,
//       'image': 'assets/images/so_da_chanh.webp',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Bánh Hạt Dẻ',
//       'price': 30000,
//       'image': 'assets/images/banh_hat_de.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Nước Ép Dưa Hấu',
//       'price': 30000,
//       'image': 'assets/images/nuoc_ep_dua_hau.jpg',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Chè Thái',
//       'price': 35000,
//       'image': 'assets/images/che_thai.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Bánh Tráng Trộn',
//       'price': 25000,
//       'image': 'assets/images/banh_trang_tron.jpg',
//       'type': 'Món tráng miệng',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     loadCategories();
//   }

//   void loadCategories() async {
//     final data = await dbhelper.getAllCategories();
//     setState(() {
//       listCategory = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thực đơn'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed:
//               // () => Navigator.pushReplacement(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => HomeScreen()),
//               // ),
//               () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.sort),
//                     label: Text('Sắp xếp'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.category),
//                     label: Text('Dịch vụ'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.location_on),
//                     label: Text('Gần tôi'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.star),
//                     label: Text('Yêu thích'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 90, // Chiều cao của GridView
//               child: GridView.count(
//                 crossAxisCount: 2, // Hai cột trong GridView
//                 mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
//                 crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
//                 childAspectRatio: 2,
//                 children: [
//                   //khung A
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       side: BorderSide(color: Colors.orange),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 50,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade100,
//                                 borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(30),
//                                   bottomRight: Radius.circular(30),
//                                   topLeft: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   'assets/icons/gift-svgrepo-com.svg',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Đang có',
//                                       style: TextStyle(fontSize: 14),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       'khuyến mãi',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 40,
//                               height: 40,
//                               child: Center(
//                                 child: Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.orange,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   //khung B
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       side: BorderSide(color: Colors.blue),
//                     ),
//                     color: const Color.fromARGB(255, 10, 24, 178),
//                     //color: Colors.blue.shade800,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 55,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 //color: const Color.fromARGB(255, 10, 24, 178),
//                                 color: Colors.blue.shade800,
//                                 borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(30),
//                                   bottomRight: Radius.circular(30),
//                                   topLeft: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   'assets/icons/order-food-svgrepo-com.svg',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Đặt món ngay',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       '4 hộp quà',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 30,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Center(
//                                 child: Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(children: buildMenuList()),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddMenuScreen()),
//           );
//         },
//         tooltip: "Thêm đơn hàng",
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   List<Widget> buildMenuList() {
//     Map<String, List<Map<String, dynamic>>> groupedMenu = {};
//     for (var item in menuItems) {
//       if (!groupedMenu.containsKey(item['type'])) {
//         groupedMenu[item['type']] = [];
//       }
//       groupedMenu[item['type']]!.add(item);
//     }

//     List<Widget> menuWidgets = [];
//     groupedMenu.forEach((type, items) {
//       // menuWidgets.add(
//       //   Padding(
//       //     padding: const EdgeInsets.all(8.0),
//       //     child: Text(
//       //       type,
//       //       style: TextStyle(
//       //         fontSize: 24,
//       //         fontWeight: FontWeight.bold,
//       //         color: Colors.brown,
//       //       ),

//       //     ),

//       //   ),
//       // );
//       menuWidgets.add(
//         // Row(
//         //   children: [
//         //     Padding(
//         //       padding: const EdgeInsets.all(8.0),
//         //       child: Text(
//         //         type,
//         //         style: GoogleFonts.grenze(
//         //           fontSize: 24,
//         //           fontWeight: FontWeight.bold,
//         //           color: Colors.brown,
//         //         ),
//         //       ),
//         //     ),
//         //     //  Expanded(child: Divider(color: Colors.grey, thickness: 0.25)),
//         //   ],
//         // ),
//         Row(
//           children:
//               listCategory.map((category) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   // backgroundColor: Colors.brown,
//                   child: Text(
//                     category.name ?? '',
//                     style: GoogleFonts.grenze(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.brown,
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//       );
//       for (var item in items) {
//         menuWidgets.add(
//           Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//             color: Colors.brown[50],
//             elevation: 5,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   //colors: [Color(0xFFC31432), Color.fromARGB(255, 54, 14, 83)],
//                   colors: [Color.fromARGB(255, 54, 14, 83), Color(0xFFC31432)],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: ListTile(
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(12.0),
//                   // child: Image.network(
//                   //   'https://baothainguyen.vn/file/e7837c027f6ecd14017ffa4e5f2a0e34/032024/picture1_20240315162010.png',
//                   child: Image.asset(
//                     item['image'],
//                     width: 80,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 title: Text(
//                   item['name'],
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 subtitle: SizedBox(
//                   width: 100,
//                   child: Text(
//                     item['type'],
//                     style: TextStyle(color: Colors.white60),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 trailing: Text(
//                   'Giá: ${item['price']} VND',
//                   style: TextStyle(
//                     color: Colors.yellow,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     });
//     return menuWidgets;
//   }
// }

//test dữ liệu
// import 'package:dt02_nhom09/class/categories.dart';
// import 'package:dt02_nhom09/screens/home.dart';
// import 'package:dt02_nhom09/screens/modalCrud/addMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MenuScreen extends StatelessWidget {
//   final List<Category> listCategory = [];
//   final List<Map<String, dynamic>> menuItems = [
//     {
//       'name': 'Phở Bò',
//       'price': 50000,
//       'image': 'assets/images/pho_bo.jpg',
//       'type': 'Món ăn chính',
//     },
//     {
//       'name': 'Cà phê Sữa',
//       'price': 30000,
//       'image': 'assets/images/cafe_sua.webp',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Bánh Flan',
//       'price': 25000,
//       'image': 'assets/images/banh_flan.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Bún Bò',
//       'price': 55000,
//       'image': 'assets/images/bun_bo.jpg',
//       'type': 'Món ăn chính',
//     },
//     {
//       'name': 'Trà Đào',
//       'price': 35000,
//       'image': 'assets/images/tra_dao.jpg',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Kem Dừa',
//       'price': 30000,
//       'image': 'assets/images/kem_dua.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Cơm Gà',
//       'price': 60000,
//       'image': 'assets/images/com_ga.jpg',
//       'type': 'Món ăn chính',
//     },
//     {
//       'name': 'Sinh Tố Bơ',
//       'price': 40000,
//       'image': 'assets/images/sinh_to_bo.webp',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Cheese Cake',
//       'price': 45000,
//       'image': 'assets/images/cheese_cake.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Mì Quảng',
//       'price': 55000,
//       'image': 'assets/images/mi_quang_ga.png',
//       'type': 'Món ăn chính',
//     },
//     {
//       'name': 'Nước Ép Cam',
//       'price': 30000,
//       'image': 'assets/images/nuoc_ep_cam.jpg',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Chè Dưỡng Nhan',
//       'price': 20000,
//       'image': 'assets/images/che_duong_nhan.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Soda Chanh',
//       'price': 25000,
//       'image': 'assets/images/so_da_chanh.webp',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Bánh Hạt Dẻ',
//       'price': 30000,
//       'image': 'assets/images/banh_hat_de.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Nước Ép Dưa Hấu',
//       'price': 30000,
//       'image': 'assets/images/nuoc_ep_dua_hau.jpg',
//       'type': 'Đồ uống',
//     },
//     {
//       'name': 'Chè Thái',
//       'price': 35000,
//       'image': 'assets/images/che_thai.jpg',
//       'type': 'Món tráng miệng',
//     },
//     {
//       'name': 'Bánh Tráng Trộn',
//       'price': 25000,
//       'image': 'assets/images/banh_trang_tron.jpg',
//       'type': 'Món tráng miệng',
//     },
//   ];

//   MenuScreen({super.key});

//   //  @override
//   // void initState() {
//   //   super.initState();
//   //   _loadUsers();
//   // }

//   // void loadCategories() {
//   //   setState(() {
//   //     _usersFuture = dbHelper.getAllUsers().then((users) {
//   //       _allUsers = users;
//   //       _applyFilters();
//   //       return users;
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thực đơn'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed:
//               // () => Navigator.pushReplacement(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => HomeScreen()),
//               // ),
//               () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.sort),
//                     label: Text('Sắp xếp'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.category),
//                     label: Text('Dịch vụ'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.location_on),
//                     label: Text('Gần tôi'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.star),
//                     label: Text('Yêu thích'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 90, // Chiều cao của GridView
//               child: GridView.count(
//                 crossAxisCount: 2, // Hai cột trong GridView
//                 mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
//                 crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
//                 childAspectRatio: 2,
//                 children: [
//                   //khung A
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       side: BorderSide(color: Colors.orange),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 50,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade100,
//                                 borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(30),
//                                   bottomRight: Radius.circular(30),
//                                   topLeft: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   'assets/icons/gift-svgrepo-com.svg',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Đang có',
//                                       style: TextStyle(fontSize: 14),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       'khuyến mãi',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 40,
//                               height: 40,
//                               child: Center(
//                                 child: Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.orange,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   //khung B
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       side: BorderSide(color: Colors.blue),
//                     ),
//                     color: const Color.fromARGB(255, 10, 24, 178),
//                     //color: Colors.blue.shade800,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 55,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 //color: const Color.fromARGB(255, 10, 24, 178),
//                                 color: Colors.blue.shade800,
//                                 borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(30),
//                                   bottomRight: Radius.circular(30),
//                                   topLeft: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   'assets/icons/order-food-svgrepo-com.svg',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Đặt món ngay',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       '4 hộp quà',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 30,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Center(
//                                 child: Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(children: _buildMenuList()),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddMenuScreen()),
//           );
//         },
//         tooltip: "Thêm đơn hàng",
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   List<Widget> _buildMenuList() {
//     Map<String, List<Map<String, dynamic>>> groupedMenu = {};
//     for (var item in menuItems) {
//       if (!groupedMenu.containsKey(item['type'])) {
//         groupedMenu[item['type']] = [];
//       }
//       groupedMenu[item['type']]!.add(item);
//     }

//     List<Widget> menuWidgets = [];
//     groupedMenu.forEach((type, items) {
//       // menuWidgets.add(
//       //   Padding(
//       //     padding: const EdgeInsets.all(8.0),
//       //     child: Text(
//       //       type,
//       //       style: TextStyle(
//       //         fontSize: 24,
//       //         fontWeight: FontWeight.bold,
//       //         color: Colors.brown,
//       //       ),

//       //     ),

//       //   ),
//       // );
//       menuWidgets.add(
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 type,
//                 style: GoogleFonts.grenze(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.brown,
//                 ),
//               ),
//             ),
//             //  Expanded(child: Divider(color: Colors.grey, thickness: 0.25)),
//           ],
//         ),
//       );
//       for (var item in items) {
//         menuWidgets.add(
//           Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//             color: Colors.brown[50],
//             elevation: 5,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   //colors: [Color(0xFFC31432), Color.fromARGB(255, 54, 14, 83)],
//                   colors: [Color.fromARGB(255, 54, 14, 83), Color(0xFFC31432)],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: ListTile(
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(12.0),
//                   // child: Image.network(
//                   //   'https://baothainguyen.vn/file/e7837c027f6ecd14017ffa4e5f2a0e34/032024/picture1_20240315162010.png',
//                   child: Image.asset(
//                     item['image'],
//                     width: 80,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 title: Text(
//                   item['name'],
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 subtitle: SizedBox(
//                   width: 100,
//                   child: Text(
//                     item['type'],
//                     style: TextStyle(color: Colors.white60),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 trailing: Text(
//                   'Giá: ${item['price']} VND',
//                   style: TextStyle(
//                     color: Colors.yellow,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     });
//     return menuWidgets;
//   }
// }

//test function and state
// lib/screens/menu_screen.dart
import 'package:dt02_nhom09/class/ImgUtil.dart';
import 'package:dt02_nhom09/class/categories.dart';
import 'package:dt02_nhom09/class/listFood.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:dt02_nhom09/screens/modalCrud/addMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final db = DatabaseHelper();
  late Future<Map<Category, List<Dish>>> _menuFuture;

  @override
  void initState() {
    super.initState();
    _menuFuture = _loadMenu();
  }

  Future<Map<Category, List<Dish>>> _loadMenu() async {
    final cats = await db.getAllCategories();
    final dishes = await db.getAllDishes();

    // gom món theo category
    final Map<Category, List<Dish>> result = {for (final c in cats) c: []};
    for (final d in dishes) {
      final cat = cats.firstWhere(
        (c) => c.id == d.categoryId,
        orElse: () => Category(id: 0, name: 'Khác'),
      );
      result[cat]!.add(d);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thực đơn'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<Map<Category, List<Dish>>>(
        future: _menuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          final menuMap = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.only(bottom: 80),
            children: [
              _buildQuickActionRow(),
              _buildBannerRow(),
              ...menuMap.entries.expand(
                (entry) => [
                  _buildCategoryHeader(entry.key.name ?? 'Không tên'),
                  ...entry.value.map(_buildDishCard),
                ],
              ),
            ],
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Thêm món',
      //   onPressed:
      //       () => Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (_) => AddMenuScreen()),
      //       ),

      //   child: const Icon(Icons.add),
      // ),

      //test
      floatingActionButton: FloatingActionButton(
        tooltip: 'Thêm món',
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => const AddMenuScreen()),
          );

          if (result == true) {
            final future = _loadMenu();
            setState(() {
              _menuFuture = future;
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // ───────────────  Widgets con  ────────────────
  Widget _buildQuickActionRow() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _quickBtn(Icons.sort, 'Sắp xếp'),
          _quickBtn(Icons.category, 'Dịch vụ'),
          _quickBtn(Icons.location_on, 'Gần tôi'),
          _quickBtn(Icons.star, 'Yêu thích'),
        ],
      ),
    ),
  );

  Widget _quickBtn(IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
      ),
      onPressed: () {},
      icon: Icon(icon),
      label: Text(text),
    ),
  );

  Widget _buildBannerRow() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SizedBox(
      height: 90,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2,
        children: [
          _bannerCard(
            colorBorder: Colors.orange,
            iconAsset: 'assets/icons/gift-svgrepo-com.svg',
            title1: 'Đang có',
            title2: 'khuyến mãi',
          ),
          _bannerCard(
            colorBorder: Colors.blue,
            bgColor: const Color(0xFF1018B2),
            iconAsset: 'assets/icons/order-food-svgrepo-com.svg',
            title1: 'Đặt món ngay',
            title2: '4 hộp quà',
            titleColor: Colors.white,
          ),
        ],
      ),
    ),
  );

  Card _bannerCard({
    required Color colorBorder,
    required String iconAsset,
    required String title1,
    required String title2,
    Color? bgColor,
    Color? titleColor,
  }) => Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: colorBorder),
    ),
    color: bgColor,
    child: Row(
      children: [
        Container(
          width: 55,
          height: 60,
          decoration: BoxDecoration(
            color: bgColor ?? Colors.orange.shade100,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(30),
            ),
          ),
          child: Center(child: SvgPicture.asset(iconAsset)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: TextStyle(
                    fontSize: 14,
                    color: titleColor ?? Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title2,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: titleColor ?? Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(Icons.arrow_forward, color: colorBorder),
        ),
        const SizedBox(width: 6),
      ],
    ),
  );

  Widget _buildCategoryHeader(String name) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      name,
      style: GoogleFonts.grenze(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.brown,
      ),
    ),
  );

  Widget _buildDishCard(Dish d) => Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF361E53), Color(0xFFC31432)],
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListTile(
        // leading: ClipRRect(
        //   borderRadius: BorderRadius.circular(12),
        //   child: Image.asset(
        //     d.imageUrl! , // đảm bảo đường dẫn ảnh đúng
        //     width: 80,
        //     height: 100,
        //     fit: BoxFit.cover,
        //   ),
        // ),

        //test nè
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child:
          (d.imageUrl == null)
              ? Container() // hoặc ảnh mặc định
              : (d.imageUrl!.startsWith('assets/'))
              ? Image.asset(
                d.imageUrl!,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              )
              : Image.memory(
                Utility.dataFromBase64String(d.imageUrl!),
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
          
        ),

        title: Text(
          d.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        // subtitle: const SizedBox(
        //   width: 60,
        //   child: Text(
        //     '',
        //     style: TextStyle(color: Colors.white60),
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRatingStars(d.rating, d.ratingCount),
            const SizedBox(height: 4),
            Text(
              d.status,
              style: TextStyle(
                color:
                    d.status == 'Hết món'
                        ? Colors.redAccent
                        : Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),

        trailing: Text(
          'Giá: ${d.price.toStringAsFixed(0)} VND',
          style: const TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
  Widget _buildRatingStars(double rating, int ratingCount) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          const Icon(Icons.star, color: Colors.amber, size: 16),
        if (hasHalfStar)
          const Icon(Icons.star_half, color: Colors.amber, size: 16),
        for (int i = 0; i < emptyStars; i++)
          const Icon(Icons.star_border, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        Text(
          '($ratingCount)',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
