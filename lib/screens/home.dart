// import 'package:dt02_nhom09/screens/login_screen.dart';
// import 'package:dt02_nhom09/screens/orderscreen.dart';
// import 'package:dt02_nhom09/screens/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:dt02_nhom09/screens/slashscreen.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// import 'package:dt02_nhom09/screens/menu.dart';
// import 'package:dt02_nhom09/class/gridItem_custom_class.dart';
// import './order_mode.dart';

// // class GirdItem {
// //   final String title;
// //   final Widget icon;

// //   GirdItem({required this.title, required this.icon});
// // }

// class HomeScreen extends StatefulWidget {
//   // const HomeScreen({super.key});
//   final String name;
//   final String role;
//   final int id;

//   const HomeScreen({
//     super.key,
//     required this.id,
//     required this.name,
//     required this.role,
//   });
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<Map<String, dynamic>> featuredItems = [
//     {'name': 'Phở Bò', 'price': 50000, 'image': 'assets/images/pho_bo.jpg'},
//     {'name': 'Trà Đào', 'price': 35000, 'image': 'assets/images/tra_dao.jpg'},
//     {'name': 'Bún Bò', 'price': 55000, 'image': 'assets/images/bun_bo.jpg'},
//     {
//       'name': 'Cheese Cake',
//       'price': 45000,
//       'image': 'assets/images/banner1.jpg',
//     },
//     {
//       'name': 'Cheese Cake',
//       'price': 45000,
//       'image': 'assets/images/banner2.jpg',
//     },
//     {
//       'name': 'Cheese Cake',
//       'price': 45000,
//       'image': 'assets/images/banner3.jpg',
//     },
//   ];

//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     if (index == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => MenuScreen()),
//       );
//     } else if (index == 2) {
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => ProfileScreen()),
//       // );
//       Navigator.pushNamed(context, '/profile', arguments: {'id': widget.id});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<GirdItem> lst = [
//       GirdItem(
//         title: 'Đặt bàn',
//         icon: FaIcon(
//           FontAwesomeIcons.calendarAlt,
//           size: 40,
//           color: Colors.deepOrange,
//         ),
//         onTap: () => {Navigator.pushNamed(context, '/tables')},
//       ),
//       GirdItem(
//         title: 'Thực đơn',
//         icon: FaIcon(FontAwesomeIcons.utensils, size: 40, color: Colors.green),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => MenuScreen()),
//           );
//         },
//       ),

//       GirdItem(
//         title: 'Thanh toán',
//         icon: FaIcon(FontAwesomeIcons.creditCard, size: 40, color: Colors.blue),
//         onTap: () => {Navigator.pushNamed(context, '/payment')},
//       ),
//       GirdItem(
//         title: 'Đơn hàng',
//         icon: FaIcon(
//           FontAwesomeIcons.clipboardList,
//           size: 40,
//           color: Colors.purple,
//         ),
//         onTap:
//             () => {
//               Navigator.pushNamed(
//                 context,
//                 '/order',
//                 arguments: {
//                   'role': widget.role,
//                   'id': widget.id,
//                   'fullname': widget.name,
//                 },
//               ),
//             },
//       ),
//       GirdItem(
//         title: 'Quản lý nhân viên',
//         icon: FaIcon(FontAwesomeIcons.users, size: 40, color: Colors.brown),
//       ),
//       GirdItem(
//         title: 'Ca làm việc',
//         icon: FaIcon(FontAwesomeIcons.clock, size: 40, color: Colors.orange),
//         onTap: () {
//           // Thực hiện hành động khi nhấn vào "Ca làm việc"
//           // Ví dụ: mở màn hình cho chức năng ca làm việc
//         },
//       ),

//       GirdItem(
//         title: 'Thống kê doanh thu',
//         icon: FaIcon(FontAwesomeIcons.chartBar, size: 40, color: Colors.teal),
//       ),
//       GirdItem(
//         title: 'Phản hồi của khách hàng',
//         icon: FaIcon(FontAwesomeIcons.comments, size: 40, color: Colors.pink),
//       ),
//       GirdItem(
//         title: 'Cài đặt',
//         icon: FaIcon(FontAwesomeIcons.cog, size: 40, color: Colors.grey),
//       ),
//       GirdItem(
//         title: 'Xem thêm',
//         icon: FaIcon(FontAwesomeIcons.ellipsisH, size: 40),
//       ),
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Trang chủ'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               print("tìm kiếm");
//             },
//             // onPressed: () {
//             //   showSearch(context: context, delegate: context);
//             // },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               // accountName: Text('Đặng Như Huỳnh'),
//               accountName: Text('${widget.name} (${widget.role})'),
//               accountEmail: Text('${widget.name}@huit.edu.vn'),

//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/logo_huit.png'),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.store),
//               title: Text('Cửa hàng'),
//               onTap: () {
//                 // Navigator.pushReplacement(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => HomeScreen(name, role)),
//                 // );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Cài đặt'),
//               onTap: () {
//                 // Navigator.pushReplacement(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => HomeScreen()),
//                 // );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.exit_to_app),
//               title: Text('Thoát'),
//               onTap: () {
//                 // Navigator.pushReplacement(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => SplashScreen()),
//                 // );
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginScreen()),
//                   (route) => false,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       // body: Center(child: Text('Danh sách sản phẩm sẽ hiển thị ở đây')),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // CarouselSlider(
//             //   options: CarouselOptions(height: 180.0, autoPlay: true),
//             //   items:
//             //       featuredItems.map((item) {
//             //         return Builder(
//             //           builder: (BuildContext context) {
//             //             return Container(
//             //               width: MediaQuery.of(context).size.width,
//             //               margin: EdgeInsets.symmetric(horizontal: 5.0),
//             //               decoration: BoxDecoration(color: Colors.amber),
//             //               child: Image.asset(item['image'], fit: BoxFit.cover),
//             //             );
//             //           },
//             //         );
//             //       }).toList(),
//             // ),

//             //test
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: MediaQuery.of(context).size.height * 0.3,
//                 autoPlay: true,
//                 viewportFraction: 1.0, // Đảm bảo ảnh full chiều rộng
//                 enlargeCenterPage: false,
//               ),
//               items:
//                   featuredItems.map((item) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return Container(
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(color: Colors.amber),
//                           child: Image.asset(
//                             item['image'],
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         );
//                       },
//                     );
//                   }).toList(),
//             ),
//             SizedBox(height: 10.0),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Các lựa chọn',
//                 style: GoogleFonts.roboto(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             GridView.builder(
//               itemCount: lst.length,
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, // Số lượng cột
//                 crossAxisSpacing: 5, // Khoảng cách giữa các cột
//                 mainAxisSpacing: 5, // Khoảng cách giữa các hàng
//                 mainAxisExtent: 100, // Chiều cao mỗi ô
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: lst[index].onTap,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.transparent,
//                     ),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           ClipOval(
//                             child: Container(
//                               color: Colors.white,
//                               width: 60,
//                               height: 60,
//                               padding: EdgeInsets.all(8),
//                               child: Center(child: lst[index].icon),
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 8),
//                               child: Text(
//                                 lst[index].title,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   height: 1.5,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 softWrap: true,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Danh sách thực đơn nổi bật',
//                 style: GoogleFonts.roboto(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             // Expanded(
//             //   child: GridView.builder(
//             //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             //       crossAxisCount: 2,
//             //       crossAxisSpacing: 10.0,
//             //       mainAxisSpacing: 10.0,
//             //     ),
//             //     itemCount: featuredItems.length,
//             //     itemBuilder: (context, index) {
//             //       return Card(
//             //         child: Column(
//             //           children: [
//             //             Expanded(
//             //               child: Image.asset(
//             //                 featuredItems[index]['image'],
//             //                 fit: BoxFit.cover,
//             //                 width: double.infinity,
//             //               ),
//             //             ),
//             //             Padding(
//             //               padding: const EdgeInsets.all(8.0),
//             //               child: Text(
//             //                 featuredItems[index]['name'],
//             //                 style: GoogleFonts.roboto(
//             //                   fontSize: 18,
//             //                   fontWeight: FontWeight.bold,
//             //                 ),
//             //               ),
//             //             ),
//             //           ],
//             //         ),
//             //       );
//             //     },
//             //   ),
//             // ),

//             //test
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children:
//                       featuredItems.map((item) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                           child: Card(
//                             elevation: 3,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Container(
//                                   width: 150,
//                                   height: 150,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     image: DecorationImage(
//                                       image: AssetImage(item['image']),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     item['name'],
//                                     style: GoogleFonts.roboto(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 8.0),
//                                   child: Text(
//                                     '${item['price']} VND',
//                                     style: GoogleFonts.roboto(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu_book),
//             label: 'Thực Đơn',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài Khoản'),
//         ],
//         selectedItemColor: const Color.fromARGB(255, 85, 2, 2),
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }

//test
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/login_screen.dart';
import 'package:dt02_nhom09/screens/menu.dart';
import 'package:dt02_nhom09/screens/profile_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dt02_nhom09/class/gridItem_custom_class.dart';
import 'package:dt02_nhom09/screens/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String role; // "Quản lý" | "Nhân viên phục vụ" | "Bếp" | "Khách hàng"
  final int id;

  const HomeScreen({
    super.key,
    required this.id,
    required this.name,
    required this.role,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /* ---------------------------------------------------------------------------
   *  Danh sách món nổi bật đưa vào carousel và list
   * ------------------------------------------------------------------------ */
  final List<Map<String, dynamic>> featuredItems = [
    {'name': 'Phở Bò', 'price': 50000, 'image': 'assets/images/pho_bo.jpg'},
    {'name': 'Trà Đào', 'price': 35000, 'image': 'assets/images/tra_dao.jpg'},
    {'name': 'Bún Bò', 'price': 55000, 'image': 'assets/images/bun_bo.jpg'},
    {
      'name': 'Cheese Cake',
      'price': 45000,
      'image': 'assets/images/banner1.jpg',
    },
    {
      'name': 'Cheese Cake',
      'price': 45000,
      'image': 'assets/images/banner2.jpg',
    },
    {
      'name': 'Cheese Cake',
      'price': 45000,
      'image': 'assets/images/banner3.jpg',
    },
  ];

  /* ---------------------------------------------------------------------------
   *  BottomNavigationBar
   * ------------------------------------------------------------------------ */
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MenuScreen()),
        );
        break;
      case 2:
        Navigator.pushNamed(context, '/profile', arguments: widget.id);
        break;
      default:
        break;
    }
  }

  /* ---------------------------------------------------------------------------
   *  Hàm sinh GridItem dựa trên quyền (role)
   * ------------------------------------------------------------------------ */
  List<GirdItem> _getGridItems(BuildContext ctx) {
    // 1) Khai báo một lần toàn bộ item
    final allItems = <String, GirdItem>{
      'Đặt bàn': GirdItem(
        title: 'Đặt bàn',
        icon: const FaIcon(
          FontAwesomeIcons.calendarAlt,
          size: 40,
          color: Colors.deepOrange,
        ),
        onTap: () => Navigator.pushNamed(ctx, '/tables'),
      ),
      'Thực đơn': GirdItem(
        title: 'Thực đơn',
        icon: const FaIcon(
          FontAwesomeIcons.utensils,
          size: 40,
          color: Colors.green,
        ),
        onTap:
            () => Navigator.push(
              ctx,
              MaterialPageRoute(builder: (_) => MenuScreen()),
            ),
      ),
      'Thanh toán': GirdItem(
        title: 'Thanh toán',
        icon: const FaIcon(
          FontAwesomeIcons.creditCard,
          size: 40,
          color: Colors.blue,
        ),
        onTap: () => Navigator.pushNamed(ctx, '/payment'),
      ),
      'Đơn hàng': GirdItem(
        title: 'Đơn hàng',
        icon: const FaIcon(
          FontAwesomeIcons.clipboardList,
          size: 40,
          color: Colors.purple,
        ),
        onTap:
            () => Navigator.pushNamed(
              ctx,
              '/order',
              arguments: {
                'role': widget.role,
                'id': widget.id,
                'fullname': widget.name,
              },
            ),
      ),
      'Quản lý nhân viên': GirdItem(
        title: 'Quản lý nhân viên',
        icon: const FaIcon(
          FontAwesomeIcons.users,
          size: 40,
          color: Colors.brown,
        ),
        onTap: () => Navigator.pushNamed(ctx, '/staff'),
      ),
      'Ca làm việc': GirdItem(
        title: 'Ca làm việc',
        icon: const FaIcon(
          FontAwesomeIcons.clock,
          size: 40,
          color: Colors.orange,
        ),
        // onTap: () => Navigator.pushNamed(ctx, '/shifts'),
        onTap:
            () => Navigator.pushNamed(context, '/chef', arguments: widget.id),
      ),
      'Thống kê doanh thu': GirdItem(
        title: 'Thống kê doanh thu',
        icon: const FaIcon(
          FontAwesomeIcons.chartBar,
          size: 40,
          color: Colors.teal,
        ),
        onTap: () => Navigator.pushNamed(ctx, '/report'),
      ),
      'Phản hồi của khách hàng': GirdItem(
        title: 'Phản hồi của khách hàng',
        icon: const FaIcon(
          FontAwesomeIcons.comments,
          size: 40,
          color: Colors.pink,
        ),
        onTap: () => Navigator.pushNamed(ctx, '/feedback'),
      ),
      'Cài đặt': GirdItem(
        title: 'Cài đặt',
        icon: const FaIcon(FontAwesomeIcons.cog, size: 40, color: Colors.grey),
        onTap: () => Navigator.pushNamed(ctx, '/settings'),
      ),
      'Xem thêm': GirdItem(
        title: 'Xem thêm',
        icon: const FaIcon(FontAwesomeIcons.ellipsisH, size: 40),
        onTap:
            () => ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Tính năng sắp ra mắt!')),
            ),
      ),
    };

    // 2) Chọn key phù hợp với role
    late final List<String> allowedKeys;
    switch (widget.role.trim().toLowerCase()) {
      case 'quản lý':
        allowedKeys = allItems.keys.toList(); // tất cả
        break;
      case 'nhân viên phục vụ':
      case 'bếp':
        allowedKeys = [
          'Đặt bàn',
          'Thực đơn',
          'Thanh toán',
          'Đơn hàng',
          'Ca làm việc',
          'Thống kê doanh thu',
          'Phản hồi của khách hàng',
          'Cài đặt',
          'Xem thêm',
        ];
        break;
      case 'khách hàng':
      default:
        allowedKeys = [
          'Đặt bàn',
          'Thực đơn',
          'Thanh toán',
          'Đơn hàng',
          'Phản hồi của khách hàng',
          'Cài đặt',
          'Xem thêm',
        ];
        break;
    }

    // 3) Trả về danh sách đã lọc
    return allowedKeys.map((k) => allItems[k]!).toList();
  }

  /* ---------------------------------------------------------------------------
   *  Giao diện
   * ------------------------------------------------------------------------ */
  @override
  Widget build(BuildContext context) {
    final gridItems = _getGridItems(context);

    return Scaffold(
      /* --------------------------- APP BAR ---------------------------------- */
      appBar: AppBar(
        title: const Text('Trang chủ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => print('Tìm kiếm'),
          ),
        ],
      ),

      /* --------------------------- DRAWER ----------------------------------- */
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              accountName: Text('${widget.name} (${widget.role})'),
              accountEmail: Text('${widget.name}@huit.edu.vn'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo_huit.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Cửa hàng'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Cài đặt'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Thoát'),
              onTap:
                  () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    (route) => false,
                  ),
            ),
          ],
        ),
      ),

      /* --------------------------- BODY ------------------------------------- */
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              /* -------- Banner slider -------- */
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.3,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                items:
                    featuredItems
                        .map(
                          (item) => Image.asset(
                            item['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 10),

              /* -------- Tiêu đề + Grid -------- */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Các lựa chọn',
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                itemCount: gridItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 100,
                ),
                itemBuilder: (ctx, i) {
                  final item = gridItems[i];
                  return GestureDetector(
                    onTap: item.onTap,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            color: Colors.white,
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(8),
                            child: Center(child: item.icon),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              /* -------- Sản phẩm nổi bật -------- */
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Danh sách thực đơn nổi bật',
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        featuredItems.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: AssetImage(item['image']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item['name'],
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      '${item['price']} VND',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      /* --------------------- BOTTOM NAVIGATION ----------------------------- */
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   selectedItemColor: const Color.fromARGB(255, 85, 2, 2),
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.menu_book),
      //       label: 'Thực Đơn',

      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài Khoản'),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Thực Đơn',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài Khoản'),
        ],
        selectedItemColor: const Color.fromARGB(255, 85, 2, 2),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}
