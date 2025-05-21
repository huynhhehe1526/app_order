import 'package:dt02_nhom09/screens/login_screen.dart';
import 'package:dt02_nhom09/screens/orderscreen.dart';
import 'package:dt02_nhom09/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/slashscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:dt02_nhom09/screens/menu.dart';
import 'package:dt02_nhom09/class/gridItem_custom_class.dart';

// class GirdItem {
//   final String title;
//   final Widget icon;

//   GirdItem({required this.title, required this.icon});
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<GirdItem> lst = [
      GirdItem(
        title: 'Đặt bàn',
        icon: FaIcon(
          FontAwesomeIcons.calendarAlt,
          size: 40,
          color: Colors.deepOrange,
        ),
      ),
      GirdItem(
        title: 'Thực đơn',
        icon: FaIcon(FontAwesomeIcons.utensils, size: 40, color: Colors.green),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuScreen()),
          );
        },
      ),

      GirdItem(
        title: 'Thanh toán',
        icon: FaIcon(FontAwesomeIcons.creditCard, size: 40, color: Colors.blue),
      ),
      GirdItem(
        title: 'Đơn hàng',
        icon: FaIcon(
          FontAwesomeIcons.clipboardList,
          size: 40,
          color: Colors.purple,
        ),
        onTap:
            () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderScreen()),
              ),
            },
      ),
      GirdItem(
        title: 'Quản lý nhân viên',
        icon: FaIcon(FontAwesomeIcons.users, size: 40, color: Colors.brown),
      ),
      GirdItem(
        title: 'Thống kê doanh thu',
        icon: FaIcon(FontAwesomeIcons.chartBar, size: 40, color: Colors.teal),
      ),
      GirdItem(
        title: 'Phản hồi của khách hàng',
        icon: FaIcon(FontAwesomeIcons.comments, size: 40, color: Colors.pink),
      ),
      GirdItem(
        title: 'Cài đặt',
        icon: FaIcon(FontAwesomeIcons.cog, size: 40, color: Colors.grey),
      ),
      GirdItem(
        title: 'Xem thêm',
        icon: FaIcon(FontAwesomeIcons.ellipsisH, size: 40),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("tìm kiếm");
            },
            // onPressed: () {
            //   showSearch(context: context, delegate: context);
            // },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              accountName: Text('Đặng Như Huỳnh'),
              accountEmail: Text('huynh@huit.edu.vn'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo_huit.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Cửa hàng'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Cài đặt'),
              onTap: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomeScreen()),
                // );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Thoát'),
              onTap: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => SplashScreen()),
                // );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      // body: Center(child: Text('Danh sách sản phẩm sẽ hiển thị ở đây')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CarouselSlider(
            //   options: CarouselOptions(height: 180.0, autoPlay: true),
            //   items:
            //       featuredItems.map((item) {
            //         return Builder(
            //           builder: (BuildContext context) {
            //             return Container(
            //               width: MediaQuery.of(context).size.width,
            //               margin: EdgeInsets.symmetric(horizontal: 5.0),
            //               decoration: BoxDecoration(color: Colors.amber),
            //               child: Image.asset(item['image'], fit: BoxFit.cover),
            //             );
            //           },
            //         );
            //       }).toList(),
            // ),

            //test
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.3,
                autoPlay: true,
                viewportFraction: 1.0, // Đảm bảo ảnh full chiều rộng
                enlargeCenterPage: false,
              ),
              items:
                  featuredItems.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Image.asset(
                            item['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),
            SizedBox(height: 10.0),
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
              itemCount: lst.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Số lượng cột
                crossAxisSpacing: 5, // Khoảng cách giữa các cột
                mainAxisSpacing: 5, // Khoảng cách giữa các hàng
                mainAxisExtent: 100, // Chiều cao mỗi ô
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: lst[index].onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.all(8),
                              child: Center(child: lst[index].icon),
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                lst[index].title,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
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

            // Expanded(
            //   child: GridView.builder(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       crossAxisSpacing: 10.0,
            //       mainAxisSpacing: 10.0,
            //     ),
            //     itemCount: featuredItems.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: Column(
            //           children: [
            //             Expanded(
            //               child: Image.asset(
            //                 featuredItems[index]['image'],
            //                 fit: BoxFit.cover,
            //                 width: double.infinity,
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text(
            //                 featuredItems[index]['name'],
            //                 style: GoogleFonts.roboto(
            //                   fontSize: 18,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),

            //test
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      featuredItems.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
          ],
        ),
      ),

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
