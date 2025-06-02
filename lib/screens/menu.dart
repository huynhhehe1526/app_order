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
