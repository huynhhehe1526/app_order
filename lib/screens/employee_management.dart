import 'package:flutter/material.dart';
import 'package:dt02_nhom09/class/user.dart';
import 'package:dt02_nhom09/db/db_helper.dart';

class EmployeeManagementScreen extends StatefulWidget {
  final String currentUserRole;
  const EmployeeManagementScreen({Key? key, required this.currentUserRole}) : super(key: key);

  @override
  State<EmployeeManagementScreen> createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<User>> _usersFuture;
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];

  final TextEditingController _searchController = TextEditingController();
  String _selectedRole = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _searchController.addListener(_applyFilters);
  }

  void _loadUsers() {
    setState(() {
      _usersFuture = dbHelper.getAllUsers().then((users) {
        _allUsers = users;
        _applyFilters();
        return users;
      });
    });
  }

  void _applyFilters() {
    final keyword = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        final matchKeyword = user.fullname.toLowerCase().contains(keyword);
        final matchRole = (_selectedRole == 'Tất cả') || (user.role == _selectedRole);
        return matchKeyword && matchRole;
      }).toList();
    });
  }

  void _showUserDialog({User? user}) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController usernameController = TextEditingController(text: user?.username ?? '');
    final TextEditingController fullnameController = TextEditingController(text: user?.fullname ?? '');
    final TextEditingController emailController = TextEditingController(text: user?.email ?? '');
    final TextEditingController phoneController = TextEditingController(text: user?.phone ?? '');
    final TextEditingController addressController = TextEditingController(text: user?.address ?? '');
    final TextEditingController passwordController = TextEditingController(text: user?.password ?? '');
    String selectedRole = user?.role ?? 'Nhân viên';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(user == null ? 'Thêm nhân viên mới' : 'Sửa thông tin nhân viên'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) => value!.trim().isEmpty ? 'Vui lòng nhập username' : null,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value!.trim().isEmpty ? 'Vui lòng nhập mật khẩu' : null,
                ),
                TextFormField(
                  controller: fullnameController,
                  decoration: const InputDecoration(labelText: 'Họ và tên'),
                  validator: (value) => value!.trim().isEmpty ? 'Vui lòng nhập họ và tên' : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Vui lòng nhập email';
                    if (!RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Số điện thoại'),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Địa chỉ'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: const InputDecoration(labelText: 'Vai trò'),
                  items: const [
                    DropdownMenuItem(value: 'Quản lý', child: Text('Quản lý')),
                    DropdownMenuItem(value: 'Nhân viên', child: Text('Nhân viên')),
                    DropdownMenuItem(value: 'Khách', child: Text('Khách')),
                  ],
                  onChanged: (val) {
                    if (val != null) selectedRole = val;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Hủy'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Lưu'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                User newUser = User(
                  id: user?.id,
                  username: usernameController.text.trim(),
                  password: passwordController.text.trim(),
                  fullname: fullnameController.text.trim(),
                  email: emailController.text.trim(),
                  phone: phoneController.text.trim(),
                  address: addressController.text.trim(),
                  role: selectedRole,
                  createdAt: user?.createdAt ?? DateTime.now().toIso8601String(),
                  updatedAt: DateTime.now().toIso8601String(),
                );
                try {
                  if (user == null) {
                    await dbHelper.insertUser(newUser);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thêm thành công')));
                  } else {
                    await dbHelper.updateUser(newUser);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cập nhật thành công')));
                  }
                  _loadUsers();
                  if (!mounted) return;
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _confirmDeleteUser(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa nhân viên này không?'),
        actions: [
          TextButton(child: const Text('Hủy'), onPressed: () => Navigator.of(context).pop()),
          ElevatedButton(
            child: const Text('Xóa'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await dbHelper.deleteUser(id);
              _loadUsers();
              if (!mounted) return;
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Xóa thành công')));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentUserRole != 'Quản lý') {
      return Scaffold(
        appBar: AppBar(title: const Text('Quản lý nhân viên')),
        body: const Center(child: Text('Bạn không có quyền truy cập phần này')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý nhân viên'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Tìm theo tên',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedRole,
                  items: const [
                    DropdownMenuItem(value: 'Tất cả', child: Text('Tất cả')),
                    DropdownMenuItem(value: 'Quản lý', child: Text('Quản lý')),
                    DropdownMenuItem(value: 'Nhân viên', child: Text('Nhân viên')),
                    DropdownMenuItem(value: 'Khách', child: Text('Khách')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedRole = value;
                      });
                      _applyFilters();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredUsers.isEmpty
                ? const Center(child: Text('Không tìm thấy nhân viên'))
                : ListView.builder(
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = _filteredUsers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          title: Text(
                            user.fullname,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('👤 ${user.username}'),
                              Text('📧 ${user.email}'),
                              Text('📞 ${user.phone}'),
                              Text('🎭 Vai trò: ${user.role}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => _showUserDialog(user: user),
                                tooltip: 'Chỉnh sửa',
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDeleteUser(user.id!),
                                tooltip: 'Xóa',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDialog(),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        tooltip: 'Thêm nhân viên',
      ),
    );
  }
}
