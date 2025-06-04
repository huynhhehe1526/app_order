//test giao diện
import 'dart:io';
import 'package:dt02_nhom09/class/categories.dart';
import 'package:dt02_nhom09/class/listFood.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dt02_nhom09/class/ImgUtil.dart';

class AddMenuScreen extends StatefulWidget {
  final String role;
  const AddMenuScreen({super.key, required this.role});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  Category? _selectedType;
  final db = DatabaseHelper();
  List<Category> _categories = [];
  File? _imageFile;
  final _picker = ImagePicker();

  bool _isFormatting = false;
  final _currencyFormatter = NumberFormat.decimalPattern('vi_VN');
  String _status = 'Còn';
  final _statusOptions = ['Còn', 'Sắp hết', 'Hết món'];
  @override
  void initState() {
    super.initState();
    // print('Check role ỏ add menu: ${widget.role}');
    _priceController.addListener(_formatPrice);
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    // ← thêm hàm
    final cats = await db.getAllCategories();
    setState(() => _categories = cats);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  String _imageForCategory(String name) {
    switch (name) {
      case 'Món ăn chính':
        return 'assets/images/loaiThucAn/bg_monanchinh.png';
      case 'Đồ uống':
        return 'assets/images/loaiThucAn/bg_douong.jpg';
      case 'Món tráng miệng':
        return 'assets/images/loaiThucAn/bg_montrangmieng.jpg';
      default:
        return 'assets/images/background-mau-hong-nhat-cho-powerpoint_012158014.jpg';
    }
  }

  void _formatPrice() {
    if (_isFormatting) return;
    _isFormatting = true;
    final digitsOnly = _priceController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isNotEmpty) {
      final formatted = _currencyFormatter.format(int.parse(digitsOnly));
      _priceController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    _isFormatting = false;
  }

  String? _imageBase64;
  Future<void> _pickImage(ImageSource src) async {
    final picked = await _picker.pickImage(source: src, imageQuality: 85);
    if (picked == null) return;
    final bytes = await File(picked.path).readAsBytes();
    setState(() => _imageFile = File(picked.path));
    _imageBase64 = Utility.base64String(bytes);
  }

  // thêm biến
  void _saveMenu() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_selectedType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Chọn loại món')));
      return;
    }

    try {
      final price = double.parse(_priceController.text.replaceAll('.', ''));
      final newDish = Dish(
        name: _nameController.text.trim(),
        price: price,
        imageUrl: _imageBase64,
        categoryId: _selectedType!.id!,
        status: _status,
      );

      await db.insertDish(newDish);
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Không lưu được món: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Thêm món mới'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFff9966), Color(0xFFff5e62)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                // color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chọn loại món',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      height: 120,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final cat = _categories[index];
                          // final isSelected = _selectedType == cat.name;
                          final isSelected = _selectedType?.id == cat.id;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedType = cat),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.green
                                          : Colors.transparent,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      _imageForCategory(cat.name ?? ''),
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    cat.name ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          isSelected
                                              ? const Color.fromARGB(
                                                255,
                                                8,
                                                113,
                                                59,
                                              )
                                              : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Tên món',
                                prefixIcon: Icon(Icons.restaurant),
                                border: OutlineInputBorder(),
                              ),
                              validator:
                                  (value) =>
                                      value == null || value.trim().isEmpty
                                          ? 'Nhập tên món'
                                          : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Giá (VND)',
                                prefixIcon: Icon(Icons.attach_money),
                                border: OutlineInputBorder(),
                              ),
                              validator:
                                  (value) =>
                                      value == null || value.trim().isEmpty
                                          ? 'Nhập giá'
                                          : null,
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: _status,
                              items:
                                  _statusOptions
                                      .map(
                                        (s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (v) => setState(() => _status = v!),
                              decoration: const InputDecoration(
                                labelText: 'Trạng thái',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Chọn hình ảnh',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed:
                                      () => _pickImage(ImageSource.gallery),
                                  icon: const Icon(Icons.photo_library),
                                  label: const Text('Chọn ảnh'),
                                ),
                                ElevatedButton.icon(
                                  onPressed:
                                      () => _pickImage(ImageSource.camera),
                                  icon: const Icon(Icons.camera_alt),
                                  label: const Text('Chụp ảnh'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            if (_imageFile != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  _imageFile!,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => {},
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                    ),
                                    child: const Text(
                                      'Hủy',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _saveMenu,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                    ),
                                    child: const Text(
                                      'Lưu',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
