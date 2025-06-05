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
import 'package:dt02_nhom09/db/db_helper.dart';

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

  //get information user
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final user = await DatabaseHelper().getUserById(widget.id);
    if (user != null) {
      setState(() {
        email = user.email;
      });
    }
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MenuScreen(role: widget.role)),
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
      'Bàn': GirdItem(
        title: 'Bàn',
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
              MaterialPageRoute(builder: (_) => MenuScreen(role: widget.role)),
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
      'Đặt bàn': GirdItem(
        title: 'Đặt bàn',
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
        onTap:
            () => Navigator.pushNamed(
              ctx,
              '/manage',
              arguments: {'currentUserRole': 'Quản lý'},
            ),
      ),
      'Ca làm việc': GirdItem(
        title: 'Ca làm việc',
        icon: const FaIcon(
          FontAwesomeIcons.clock,
          size: 40,
          color: Colors.orange,
        ),
        // onTap: () => Navigator.pushNamed(ctx, '/shifts'),
        // onTap:
        //     () => Navigator.pushNamed(context, '/chef', arguments: widget.id),
        onTap: () {
          final role = widget.role.trim().toLowerCase();
          if (role == 'quản lý') {
            Navigator.pushNamed(context, '/shift-role-select');
          } else {
            Navigator.pushNamed(
              context,
              '/shift-list',
              arguments: {'userId': widget.id},
            );
          }
        },
      ),
      'Chế biến món': GirdItem(
        title: 'Chế biến món',
        icon: const FaIcon(
          FontAwesomeIcons.fire,
          size: 40,
          color: Color.fromARGB(255, 230, 117, 4),
        ),
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
      case 'nhân viên':
        allowedKeys = [
          'Bàn',
          'Thực đơn',
          'Thanh toán',
          'Đặt bàn',
          'Ca làm việc',
          'Phản hồi của khách hàng',
          'Cài đặt',
          'Xem thêm',
        ];
        break;
      case 'bếp':
        allowedKeys = [
          'Bàn',
          'Thực đơn',
          'Thanh toán',
          'Ca làm việc',
          'Chế biến món',
          'Phản hồi của khách hàng',
          'Cài đặt',
          'Xem thêm',
        ];
        break;
      case 'khách hàng':
      default:
        allowedKeys = [
          'Bàn',
          'Thực đơn',
          'Thanh toán',
          'Đặt bàn',
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
  // @override
  // Widget build(BuildContext context) {
  //   final gridItems = _getGridItems(context);

  //   return Scaffold(
  //     /* --------------------------- APP BAR ---------------------------------- */
  //     appBar: AppBar(
  //       title: const Text('Trang chủ'),
  //       actions: [
  //         IconButton(
  //           icon: const Icon(Icons.search),
  //           onPressed: () => print('Tìm kiếm'),
  //         ),
  //       ],
  //     ),

  //     /* --------------------------- DRAWER ----------------------------------- */
  //     drawer: Drawer(
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         children: [
  //           UserAccountsDrawerHeader(
  //             decoration: const BoxDecoration(color: Colors.blue),
  //             accountName: Text(widget.name),
  //             // accountEmail: Text('${widget.name}@huit.edu.vn'),
  //             accountEmail: Text(email != null ? email! : 'Đang tải...'),
  //             currentAccountPicture: const CircleAvatar(
  //               backgroundImage: AssetImage('assets/images/logo_huit.png'),
  //             ),
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.store),
  //             title: const Text('Cửa hàng'),
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.settings),
  //             title: const Text('Cài đặt'),
  //             onTap: () => Navigator.pop(context),
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.exit_to_app),
  //             title: const Text('Thoát'),
  //             onTap:
  //                 () => Navigator.pushAndRemoveUntil(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => WelcomeScreen()),
  //                   (route) => false,
  //                 ),
  //           ),
  //         ],
  //       ),
  //     ),

  //     /* --------------------------- BODY ------------------------------------- */
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         padding: const EdgeInsets.only(bottom: 16),
  //         child: Column(
  //           children: [
  //             /* -------- Banner slider -------- */
  //             CarouselSlider(
  //               options: CarouselOptions(
  //                 height: MediaQuery.of(context).size.height * 0.3,
  //                 autoPlay: true,
  //                 viewportFraction: 1,
  //               ),
  //               items:
  //                   featuredItems
  //                       .map(
  //                         (item) => Image.asset(
  //                           item['image'],
  //                           fit: BoxFit.cover,
  //                           width: double.infinity,
  //                         ),
  //                       )
  //                       .toList(),
  //             ),
  //             const SizedBox(height: 10),

  //             /* -------- Tiêu đề + Grid -------- */
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
  //               itemCount: gridItems.length,
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 3,
  //                 childAspectRatio: 1,
  //                 // crossAxisSpacing: 5,
  //                 // mainAxisSpacing: 5,
  //                 // mainAxisExtent: 100,
  //               ),
  //               itemBuilder: (ctx, i) {
  //                 final item = gridItems[i];
  //                 return GestureDetector(
  //                   onTap: item.onTap,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       ClipOval(
  //                         child: Container(
  //                           color: Colors.white,
  //                           width: 60,
  //                           height: 60,
  //                           padding: const EdgeInsets.all(8),
  //                           child: Center(child: item.icon),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 5),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 6),
  //                         child: Text(
  //                           item.title,
  //                           textAlign: TextAlign.center,
  //                           style: const TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                             height: 1.5,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),


  int currentIndex = 0;

  void next() {
    setState(() {
      currentIndex = 1;
    });
  }

  void previous() {
    setState(() {
      currentIndex = 0;
    });
  }

  //test UI
  @override
  Widget build(BuildContext context) {
    final gridItems = _getGridItems(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 3,
        title: Text('Trang chủ', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepOrange),
              accountName: Text(widget.name),
              accountEmail: Text(email != null ? email! : 'Đang tải...'),
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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Slider
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.25,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                    ),
                    items:
                        featuredItems.map((item) {
                          return Image.asset(
                            item['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }).toList(),
                  ),
                ),
              ),

              // Grid title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Chức năng nhanh',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  itemCount: gridItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (ctx, i) {
                    final item = gridItems[i];
                    return GestureDetector(
                      onTap: item.onTap,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            child: item.icon,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.title,
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Featured list title
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khách hàng nói gì?',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        _buildTestimonialCard(
                          name: 'Nguyễn Văn A',
                          avatar: 'assets/images/profile_avatar.jpg',
                          feedback:
                              'Không gian đẹp, đồ uống ngon, phục vụ nhanh 👍',
                        ),
                        const SizedBox(height: 12),
                        _buildTestimonialCard(
                          name: 'Trần Thị B',
                          avatar: 'assets/images/profile_avatar.jpg',
                          feedback:
                              'Tôi rất hài lòng về trải nghiệm lần này. Sẽ quay lại!',
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/photo-1543007631-283050bb3e8c.jpg',
                          ), // nền mờ phía sau
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 30,
                        ),
                        color: Colors.white.withOpacity(0.8), // lớp phủ nhẹ
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "REVIEWS",
                              style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 20),

                            Expanded(
                              child: IndexedStack(
                                index: currentIndex,
                                children: [
                                  _buildReviewCard(
                                    name: "Customer 1",
                                    avatar: 'assets/images/profile_avatar.jpg',
                                    review:
                                        "I had a wonderful experience with the service provided. The team was professional, efficient, and responsive throughout the entire process.",
                                    showRightArrow: true,
                                    onRightArrowTap: next,
                                  ),
                                  _buildReviewCard(
                                    name: "Customer 2",
                                    avatar: "assets/images/profile_avatar.jpg",
                                    review:
                                        "The service was excellent! I felt very comfortable and will definitely come back again.",
                                    showLeftArrow: true,
                                    onLeftArrowTap: previous,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Thực Đơn',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài Khoản'),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String avatar,
    required String feedback,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 26, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.format_quote,
                      size: 20,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        feedback,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade800,
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
    );
  }

  Widget _buildReviewCard({
    required String name,
    required String avatar,
    required String review,
    bool showLeftArrow = false,
    bool showRightArrow = false,
    VoidCallback? onLeftArrowTap,
    VoidCallback? onRightArrowTap,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 32),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.edit, size: 16, color: Colors.amber),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.format_quote, color: Colors.blue, size: 24),
                  Icon(Icons.format_quote, color: Colors.blue, size: 24),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                review,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  5,
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 20,
          child: CircleAvatar(radius: 30, backgroundImage: AssetImage(avatar)),
        ),
        // Arrow buttons
        if (showRightArrow)
          Positioned(
            right: 16,
            top: 60,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: onRightArrowTap,
            ),
          ),
        if (showLeftArrow)
          Positioned(
            left: 16,
            top: 60,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: onLeftArrowTap,
            ),
          ),
      ],
    );
  }
}
