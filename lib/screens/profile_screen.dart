// //test data
// // profile_screen.dart
// import 'package:flutter/material.dart';
// import 'edit_profile_screen.dart';
// import 'login_screen.dart';
// import 'package:dt02_nhom09/screens/data/mock_data.dart';

// class ProfileScreen extends StatefulWidget {
//   final int id;
//   const ProfileScreen({super.key, required this.id});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   late Map<String, dynamic> user;

//   @override
//   void initState() {
//     super.initState();
//     user = users.firstWhere(
//       (u) => u['id'] == widget.id,
//       orElse:
//           () => {
//             'fullname': 'Không tìm thấy',
//             'email': '',
//             'phone': '',
//             'address': '',
//             'role': '',
//           },
//     );
//   }

//   // Hàm cập nhật sau khi chỉnh sửa
//   void _updateProfile(Map<String, String> newData) {
//     setState(() {
//       user = {...user, ...newData}; // gộp map
//       // nếu muốn update vào danh sách users gốc:
//       final idx = users.indexWhere((u) => u['id'] == user['id']);
//       if (idx != -1) users[idx] = user;
//     });
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: const Text('Hồ sơ cá nhân'),
//       backgroundColor: Colors.brown,
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 20),
//           Center(
//             child: CircleAvatar(
//               radius: 60,
//               backgroundImage: NetworkImage(
//                 'https://i.pravatar.cc/150?img=3',
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Center(
//             child: Text(
//               user['fullname'] ?? '',
//               style: const TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.brown,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Center(
//             child: Text(
//               user['email'] ?? '',
//               style: const TextStyle(color: Colors.grey, fontSize: 16),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Divider(color: Colors.brown, thickness: 1),
//           const SizedBox(height: 12),

//           _buildInfoRow(Icons.phone, 'SĐT', user['phone'] ?? ''),
//           _buildInfoRow(Icons.home, 'Địa chỉ', user['address'] ?? ''),
//           _buildInfoRow(Icons.badge, 'Vai trò', user['role'] ?? ''),

//           const Spacer(),
//           Center(
//             child: ElevatedButton(
//               onPressed: () async {
//                 final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder:
//                         (_) => EditProfileScreen(
//                           name: user['fullname'] ?? '',
//                           email: user['email'] ?? '',
//                           phone: user['phone'] ?? '',
//                           address: user['address'] ?? '',
//                         ),
//                   ),
//                 );
//                 if (result != null) _updateProfile(result);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.brown,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 30,
//                   vertical: 12,
//                 ),
//               ),
//               child: const Text(
//                 'Chỉnh sửa thông tin',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     ),
//   );

//   Widget _buildInfoRow(IconData icon, String label, String value) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 6.0),
//     child: Row(
//       children: [
//         Icon(icon, color: Colors.brown),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Text('$label: $value', style: const TextStyle(fontSize: 18)),
//         ),
//       ],
//     ),
//   );
// }
//test giao diện
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'package:dt02_nhom09/screens/data/mock_data.dart';

class ProfileScreen extends StatefulWidget {
  final int id;
  const ProfileScreen({super.key, required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = users.firstWhere(
      (u) => u['id'] == widget.id,
      orElse:
          () => {
            'fullname': 'Không tìm thấy',
            'email': '',
            'phone': '',
            'address': '',
            'role': '',
          },
    );
  }

  void _updateProfile(Map<String, String> newData) {
    setState(() {
      user = {...user, ...newData};
      final idx = users.indexWhere((u) => u['id'] == user['id']);
      if (idx != -1) users[idx] = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        backgroundColor: Colors.brown.shade300,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 45,
              backgroundImage: const NetworkImage(
                'https://i.pravatar.cc/150?img=3',
              ), // hoặc ảnh từ DB nếu có
              backgroundColor: Colors.brown.shade100,
            ),
            const SizedBox(height: 12),
            Text(
              user['fullname'] ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              user['email'] ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(Icons.phone, 'Số điện thoại', user['phone'] ?? ''),
            _buildInfoCard(Icons.location_on, 'Địa chỉ', user['address'] ?? ''),
            _buildInfoCard(Icons.verified_user, 'Vai trò', user['role'] ?? ''),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => EditProfileScreen(
                            name: user['fullname'] ?? '',
                            email: user['email'] ?? '',
                            phone: user['phone'] ?? '',
                            address: user['address'] ?? '',
                          ),
                    ),
                  );
                  if (result != null) _updateProfile(result);
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Chỉnh sửa thông tin',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade400,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.brown.shade300),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
