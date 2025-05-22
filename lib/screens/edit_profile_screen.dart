import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  // final String birthday;
  // final String gender;
  // final String description;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    // required this.birthday,
    // required this.gender,
    // required this.description,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  // late TextEditingController birthdayController;
  // late TextEditingController genderController;
  // late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    addressController = TextEditingController(text: widget.address);
    // birthdayController = TextEditingController(text: widget.birthday);
    // genderController = TextEditingController(text: widget.gender);
    // descriptionController = TextEditingController(text: widget.description);
  }

  void _saveProfile() {
    Navigator.pop(context, {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      // 'birthday': birthdayController.text,
      // 'gender': genderController.text,
      // 'description': descriptionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'SĐT'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Địa chỉ'),
            ),
            // TextField(
            //   controller: birthdayController,
            //   decoration: const InputDecoration(labelText: 'Ngày sinh'),
            // ),
            // TextField(
            //   controller: genderController,
            //   decoration: const InputDecoration(labelText: 'Giới tính'),
            // ),
            // TextField(
            //   controller: descriptionController,
            //   decoration: const InputDecoration(labelText: 'Mô tả'),
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              child: const Text('Lưu', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
