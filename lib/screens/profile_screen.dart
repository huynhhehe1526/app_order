//test giao diện
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'package:dt02_nhom09/class/user.dart';
import 'package:dt02_nhom09/db/db_helper.dart';

class ProfileScreen extends StatefulWidget {
  final int id;
  const ProfileScreen({super.key, required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    User? u = await dbHelper.getUserById(widget.id);
    setState(() {
      user = u;
    });
  }

  void _updateProfile(Map<String, String> newData) async {
    if (user == null) return;
    user = user!.copyWith(
      fullname: newData['fullname'],
      email: newData['email'],
      phone: newData['phone'],
      address: newData['address'],
    );
    await dbHelper.updateUser(user!);
    setState(() {}); // refresh UI
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
              ),
              backgroundColor: Colors.brown.shade100,
            ),
            const SizedBox(height: 12),
            Text(
              user!.fullname,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              user!.email,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(Icons.phone, 'Số điện thoại', user!.phone),
            _buildInfoCard(Icons.location_on, 'Địa chỉ', user!.address),
            _buildInfoCard(Icons.verified_user, 'Vai trò', user!.role),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(
                        fullname: user!.fullname,
                        email: user!.email,
                        phone: user!.phone,
                        address: user!.address,
                      ),
                    ),
                  );
                  if (result != null && result is Map<String, String>) {
                    _updateProfile(result);
                  }
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
