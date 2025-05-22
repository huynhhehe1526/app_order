import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final int id;
  const ProfileScreen({super.key, required this.id});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Nguyễn Văn Minh';
  String userEmail = 'nguyenvanminh@example.com';
  String userPhone = '0987235657';
  String userAddress = '123 Đường Nguyễn Sơn, Quận Tân Phú, TP.HCM';
  String userBirthday = '01/01/2000';
  String userGender = 'Nam';
  String userDescription = 'Yêu thích cà phê và lập trình.';
  final String avatarUrl = 'https://i.pravatar.cc/150?img=3';

  void _updateProfile(Map<String, String> updatedData) {
    setState(() {
      userName = updatedData['name'] ?? userName;
      userEmail = updatedData['email'] ?? userEmail;
      userPhone = updatedData['phone'] ?? userPhone;
      userAddress = updatedData['address'] ?? userAddress;
      userBirthday = updatedData['birthday'] ?? userBirthday;
      userGender = updatedData['gender'] ?? userGender;
      userDescription = updatedData['description'] ?? userDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        backgroundColor: Colors.brown,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.logout),
        //     onPressed: () {
        //       Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(builder: (context) => const LoginScreen()),
        //         (route) => false,
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                userName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                userEmail,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.brown, thickness: 1),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.phone, 'SĐT', userPhone),
            _buildInfoRow(Icons.home, 'Địa chỉ', userAddress),
            _buildInfoRow(Icons.cake, 'Ngày sinh', userBirthday),
            _buildInfoRow(Icons.person, 'Giới tính', userGender),
            _buildInfoRow(Icons.description, 'Mô tả', userDescription),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        name: userName,
                        email: userEmail,
                        phone: userPhone,
                        address: userAddress,
                        birthday: userBirthday,
                        gender: userGender,
                        description: userDescription,
                      ),
                    ),
                  );
                  if (result != null) {
                    _updateProfile(result);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text(
                  'Chỉnh sửa thông tin',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.brown),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
