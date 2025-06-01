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
  const AddMenuScreen({super.key});

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
  // String? _selectedType;

  // String _selectedType = 'Món ăn chính';
  File? _imageFile;
  final _picker = ImagePicker();

  bool _isFormatting = false;
  final _currencyFormatter = NumberFormat.decimalPattern('vi_VN');
  String _status = 'Còn';
  final _statusOptions = ['Còn', 'Sắp hết', 'Hết món'];
  @override
  void initState() {
    super.initState();
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

  // final List<Map<String, String>> types = [
  //   {
  //     'label': 'Món ăn chính',
  //     'image': 'assets/images/loaiThucAn/bg_monanchinh.png',
  //   },
  //   {'label': 'Đồ uống', 'image': ''},
  //   {'label': 'Món tráng miệng', 'image': ''},
  // ];

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

  // void _saveMenu() async {
  //   if (_formKey.currentState?.validate() != true) return;
  //   if (_selectedType == null) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Chọn loại món')));
  //     return;
  //   }

  //   final price = double.parse(_priceController.text.replaceAll('.', ''));
  //   final newDish = Dish(
  //     name: _nameController.text.trim(),
  //     price: price,
  //     imageUrl: _imageFile?.path ?? '',
  //     categoryId: _selectedType!.id!,
  //     status: _status,
  //   );

  //   await db.insertDish(newDish);

  //   Navigator.pop(context, true);
  // }

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

  // Future<void> _pickImage(ImageSource source) async {
  //   final picked = await _picker.pickImage(source: source, imageQuality: 85);
  //   if (picked != null) {
  //     setState(() => _imageFile = File(picked.path));
  //   }
  // }
  String? _imageBase64;
  Future<void> _pickImage(ImageSource src) async {
    final picked = await _picker.pickImage(source: src, imageQuality: 85);
    if (picked == null) return;
    final bytes = await File(picked.path).readAsBytes();
    setState(() => _imageFile = File(picked.path)); // để preview
    _imageBase64 = Utility.base64String(bytes); // << lưu chuỗi
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
      Navigator.pop(context, true); // ← trả kết quả thành công
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Không lưu được món: $e')));
    }
  }
  // void _saveMenu() {
  //   if (_formKey.currentState?.validate() != true) return;

  //   final parsedPrice = int.parse(_priceController.text.replaceAll('.', ''));

  //   final newItem = {
  //     'name': _nameController.text.trim(),
  //     'price': parsedPrice,
  //     'image': _imageFile?.path ?? '',
  //     'type': _selectedType,
  //   };

  //   Navigator.of(context).pop(newItem);
  // }

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
                child:
                //Padding(
                // padding: const EdgeInsets.all(24.0),
                Column(
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
                    // SizedBox(
                    //   height: 120,
                    //   child: GridView.count(
                    //     crossAxisCount: 1,
                    //     scrollDirection: Axis.horizontal,
                    //     mainAxisSpacing: 12,
                    //     childAspectRatio: 1,
                    //     children:
                    //         types.map((type) {
                    //           final isSelected = _selectedType == type['label'];
                    //           return GestureDetector(
                    //             onTap: () {
                    //               setState(() {
                    //                 _selectedType = type['label'];
                    //               });
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 // color: Colors.transparent,
                    //                 border: Border.all(
                    //                   color:
                    //                       isSelected
                    //                           ? Colors.green
                    //                           : Colors.transparent,
                    //                   width: 3,
                    //                 ),
                    //                 borderRadius: BorderRadius.circular(16),
                    //               ),
                    //               child: Column(
                    //                 children: [
                    //                   ClipRRect(
                    //                     borderRadius: BorderRadius.circular(12),
                    //                     child: Image.asset(
                    //                       type['image']!,
                    //                       height: 80,
                    //                       width: 80,
                    //                       fit: BoxFit.cover,
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 4),
                    //                   Text(
                    //                     type['label']!,
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.w600,
                    //                       color:
                    //                           isSelected
                    //                               ? const Color.fromARGB(
                    //                                 255,
                    //                                 8,
                    //                                 113,
                    //                                 59,
                    //                               )
                    //                               : Colors.black,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           );
                    //         }).toList(),
                    //   ),
                    // ),

                    //test
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

//testtttttttttttttttttt
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddMenuScreen extends StatefulWidget {
//   const AddMenuScreen({super.key});

//   @override
//   State<AddMenuScreen> createState() => _AddMenuScreenState();
// }

// class _AddMenuScreenState extends State<AddMenuScreen> {
//   // Dữ liệu loại món demo
//   final List<Map<String, String>> types = [
//     {
//       'label': 'Món chính',
//       'image': 'assets/images/loaiThucAn/bg_monanchinh.png',
//     },
//     {'label': 'Món phụ', 'image': 'assets/side_dish.png'},
//     {'label': 'Đồ uống', 'image': 'assets/drink.png'},
//   ];

//   String? _selectedType;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();

//   File? _imageFile;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final XFile? picked = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 75,
//     );
//     if (picked != null) {
//       setState(() {
//         _imageFile = File(picked.path);
//       });
//     }
//   }

//   void _onSave() {
//     // Kiểm tra dữ liệu đơn giản
//     if (_selectedType == null) {
//       _showSnack('Vui lòng chọn loại món.');
//       return;
//     }
//     if (_nameController.text.isEmpty) {
//       _showSnack('Vui lòng nhập tên món.');
//       return;
//     }
//     if (_priceController.text.isEmpty) {
//       _showSnack('Vui lòng nhập giá món.');
//       return;
//     }
//     if (_imageFile == null) {
//       _showSnack('Vui lòng chọn ảnh món.');
//       return;
//     }

//     // Ở đây bạn thêm code lưu món vào DB hoặc backend...

//     _showSnack('Lưu món thành công!', success: true);
//   }

//   void _showSnack(String message, {bool success = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: success ? Colors.green : Colors.red,
//       ),
//     );
//   }

//   void _onCancel() {
//     // Xoá hết dữ liệu form
//     setState(() {
//       _selectedType = null;
//       _nameController.clear();
//       _priceController.clear();
//       _imageFile = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Thêm món mới')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.95),
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Chọn loại món',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green[700],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 height: 120,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: types.length,
//                   itemBuilder: (context, index) {
//                     final type = types[index];
//                     final isSelected = _selectedType == type['label'];
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() => _selectedType = type['label']);
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         margin: const EdgeInsets.only(right: 12),
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: isSelected ? Colors.green[50] : Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color:
//                                 isSelected
//                                     ? Colors.green
//                                     : Colors.grey.shade300,
//                             width: isSelected ? 3 : 1,
//                           ),
//                           boxShadow: [
//                             if (isSelected)
//                               BoxShadow(
//                                 color: Colors.green.withOpacity(0.3),
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 5),
//                               ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child: Image.asset(
//                                 type['image']!,
//                                 height: 70,
//                                 width: 70,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               type['label']!,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color:
//                                     isSelected
//                                         ? Colors.green[800]
//                                         : Colors.grey[800],
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 24),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Tên món',
//                   prefixIcon: const Icon(Icons.restaurant_menu),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _priceController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Giá (VND)',
//                   prefixIcon: const Icon(Icons.attach_money),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Chọn ảnh món
//               Text(
//                 'Ảnh món',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.green[700],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.green, width: 2),
//                     color: Colors.green.withOpacity(0.05),
//                     image:
//                         _imageFile != null
//                             ? DecorationImage(
//                               image: FileImage(_imageFile!),
//                               fit: BoxFit.cover,
//                             )
//                             : null,
//                   ),
//                   child:
//                       _imageFile == null
//                           ? Center(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: const [
//                                 Icon(
//                                   Icons.camera_alt,
//                                   size: 40,
//                                   color: Colors.green,
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   'Chọn ảnh từ gallery',
//                                   style: TextStyle(color: Colors.green),
//                                 ),
//                               ],
//                             ),
//                           )
//                           : null,
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Nút lưu và hủy
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: _onCancel,
//                       style: OutlinedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         side: const BorderSide(color: Colors.grey),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: const Text('Hủy', style: TextStyle(fontSize: 16)),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: _onSave,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: const Text('Lưu', style: TextStyle(fontSize: 16)),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
