import 'package:dt02_nhom09/screens/home.dart';
import 'package:flutter/material.dart';
import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Nếu hợp lệ thì chuyển sang ProfileScreen
      Navigator.push(
        context,
        // MaterialPageRoute(builder: (context) => ProfileScreen()),
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Nếu chưa hợp lệ thì hiện thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ email và mật khẩu'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            // child: Image.network(
            //   'https://www.google.com/imgres?q=c%C3%A0%20ph%C3%AA%20n%E1%BB%81n%20%C4%91i%E1%BB%87n%20tho%E1%BA%A1i&imgurl=https%3A%2F%2Fcdn.tgdd.vn%2F%2FGameApp%2F-1%2F%2Fdienthoai-2-675x1200-26.jpg&imgrefurl=https%3A%2F%2Ftrungtambaohanh.com%2Fproducts%2F100-hinh-nen-background-coffee-cho-may-tinh-dien-thoai&docid=Tvendqun4VWicM&tbnid=0koi4vvFLeInjM&vet=12ahUKEwih7dP85aqNAxXJsFYBHUlnIfAQM3oECE0QAA..i&w=675&h=1200&hcb=2&ved=2ahUKEwih7dP85aqNAxXJsFYBHUlnIfAQM3oECE0QAA',
            //   fit: BoxFit.cover,
            // ),
            child: Image.asset(
              'assets/images/dienthoai-2-675x1200-26.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.brown.withAlpha(180)),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Cà phê Giao Nhanh',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          // Có thể thêm regex kiểm tra email hợp lệ nếu muốn
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          labelStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
