import 'package:dt02_nhom09/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Phở Bò',
      'price': 50000,
      'image': 'assets/images/pho_bo.jpg',
      'type': 'Món ăn chính',
    },
    {
      'name': 'Cà phê Sữa',
      'price': 30000,
      'image': 'assets/images/cafe_sua.webp',
      'type': 'Đồ uống',
    },
    {
      'name': 'Bánh Flan',
      'price': 25000,
      'image': 'assets/images/banh_flan.jpg',
      'type': 'Món tráng miệng',
    },
    {
      'name': 'Bún Bò',
      'price': 55000,
      'image': 'assets/images/bun_bo.jpg',
      'type': 'Món ăn chính',
    },
    {
      'name': 'Trà Đào',
      'price': 35000,
      'image': 'assets/images/tra_dao.jpg',
      'type': 'Đồ uống',
    },
    {
      'name': 'Kem Dừa',
      'price': 30000,
      'image': 'assets/images/kem_dua.jpg',
      'type': 'Món tráng miệng',
    },
    {
      'name': 'Cơm Gà',
      'price': 60000,
      'image': 'assets/images/com_ga.jpg',
      'type': 'Món ăn chính',
    },
    {
      'name': 'Sinh Tố Bơ',
      'price': 40000,
      'image': 'assets/images/sinh_to_bo.webp',
      'type': 'Đồ uống',
    },
    {
      'name': 'Cheese Cake',
      'price': 45000,
      'image': 'assets/images/cheese_cake.jpg',
      'type': 'Món tráng miệng',
    },
    {
      'name': 'Mì Quảng',
      'price': 55000,
      'image': 'assets/images/mi_quang_ga.png',
      'type': 'Món ăn chính',
    },
    {
      'name': 'Nước Ép Cam',
      'price': 30000,
      'image': 'assets/images/nuoc_ep_cam.jpg',
      'type': 'Đồ uống',
    },
    {
      'name': 'Chè Dưỡng Nhan',
      'price': 20000,
      'image': 'assets/images/che_duong_nhan.jpg',
      'type': 'Món tráng miệng',
    },
    {
      'name': 'Soda Chanh',
      'price': 25000,
      'image': 'assets/images/so_da_chanh.webp',
      'type': 'Đồ uống',
    },
    {
      'name': 'Bánh Hạt Dẻ',
      'price': 30000,
      'image': 'assets/images/banh_hat_de.jpg',
      'type': 'Món tráng miệng',
    },
    {
      'name': 'Nước Ép Dưa Hấu',
      'price': 30000,
      'image': 'assets/images/nuoc_ep_dua_hau.jpg',
      'type': 'Đồ uống',
    },
    {
      'name': 'Chè Thái',
      'price': 35000,
      'image': 'assets/images/che_thai.jpg',
      'type': 'Món tráng miệng',
    },
    {
      'name': 'Bánh Tráng Trộn',
      'price': 25000,
      'image': 'assets/images/banh_trang_tron.jpg',
      'type': 'Món tráng miệng',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thực đơn'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:
              // () => Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen()),
              // ),
              () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.sort),
                    label: Text('Sắp xếp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.category),
                    label: Text('Dịch vụ'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.location_on),
                    label: Text('Gần tôi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.star),
                    label: Text('Yêu thích'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 90, // Chiều cao của GridView
              child: GridView.count(
                crossAxisCount: 2, // Hai cột trong GridView
                mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
                crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
                childAspectRatio: 2,
                children: [
                  //khung A
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.orange),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/gift-svgrepo-com.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Đang có',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'khuyến mãi',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //khung B
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.blue),
                    ),
                    color: const Color.fromARGB(255, 10, 24, 178),
                    //color: Colors.blue.shade800,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 55,
                              height: 60,
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 10, 24, 178),
                                color: Colors.blue.shade800,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/order-food-svgrepo-com.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Đặt món ngay',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '4 hộp quà',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: _buildMenuList()),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuList() {
    Map<String, List<Map<String, dynamic>>> groupedMenu = {};
    for (var item in menuItems) {
      if (!groupedMenu.containsKey(item['type'])) {
        groupedMenu[item['type']] = [];
      }
      groupedMenu[item['type']]!.add(item);
    }

    List<Widget> menuWidgets = [];
    groupedMenu.forEach((type, items) {
      // menuWidgets.add(
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text(
      //       type,
      //       style: TextStyle(
      //         fontSize: 24,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.brown,
      //       ),

      //     ),

      //   ),
      // );
      menuWidgets.add(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                type,
                style: GoogleFonts.grenze(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            //  Expanded(child: Divider(color: Colors.grey, thickness: 0.25)),
          ],
        ),
      );
      for (var item in items) {
        menuWidgets.add(
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            color: Colors.brown[50],
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  //colors: [Color(0xFFC31432), Color.fromARGB(255, 54, 14, 83)],
                  colors: [Color.fromARGB(255, 54, 14, 83), Color(0xFFC31432)],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  // child: Image.network(
                  //   'https://baothainguyen.vn/file/e7837c027f6ecd14017ffa4e5f2a0e34/032024/picture1_20240315162010.png',
                  child: Image.asset(
                    item['image'],
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  item['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: SizedBox(
                  width: 100,
                  child: Text(
                    item['type'],
                    style: TextStyle(color: Colors.white60),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: Text(
                  'Giá: ${item['price']} VND',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
    return menuWidgets;
  }
}

//test đặt bàn + món

// import 'package:flutter/material.dart';

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({super.key});

//   @override
//   _MenuScreenState createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   final List<Map<String, dynamic>> menuItems = [
//     {"name": "Cafe Sữa", "price": 20000},
//     {"name": "Trà Đào", "price": 25000},
//     {"name": "Bánh Mì", "price": 15000},
//   ];

//   int total = 0;

//   @override
//   Widget build(BuildContext context) {
//     final String tableName =
//         ModalRoute.of(context)?.settings.arguments as String;

//     return Scaffold(
//       appBar: AppBar(title: Text("Thực đơn - $tableName")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: menuItems.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(menuItems[index]["name"]),
//                   subtitle: Text("${menuItems[index]["price"]} đ"),
//                   trailing: Icon(Icons.add),
//                   onTap: () {
//                     setState(() {
//                       total += menuItems[index]["price"] as int;
//                     });

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           'Đã thêm ${menuItems[index]["name"]} - ${menuItems[index]["price"]}đ',
//                         ),
//                         duration: Duration(seconds: 1),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton.icon(
//               onPressed:
//                   total > 0
//                       ? () {
//                         Navigator.pushNamed(
//                           context,
//                           '/payment',
//                           arguments: {"table": tableName, "total": total},
//                         );
//                       }
//                       : null,
//               icon: Icon(Icons.payment),
//               label: Text("Thanh toán ($total đ)"),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(double.infinity, 50),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
