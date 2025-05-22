import 'package:dt02_nhom09/screens/custom_welcome.dart';
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/home.dart';
import 'package:dt02_nhom09/screens/sign_up.dart';
import 'package:dt02_nhom09/screens/data/mock_data.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void _handleLogin() {
    if (_formSignInKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final user = users.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        final id = user['id']!;
        final role = user['role']!;
        final name = user['fullname']!;

        // Thông báo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chào $name - $role'),
            backgroundColor: Colors.green,
          ),
        );

        // Chuyển sang trang Home (hoặc tuỳ vai trò có thể chuyển trang khác nhau)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => HomeScreen(
                  id: int.parse(id.toString()),
                  name: name,
                  role: role,
                ),
          ),
        );
      } else {
        // Sai tài khoản hoặc mật khẩu
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sai email hoặc mật khẩu!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Form chưa hợp lệ
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
    return CustomWelcome(
      child: Stack(
        children: [
          const Expanded(flex: 1, child: SizedBox(height: 10)),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.4),
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.white.withOpacity(0.0), // Trong suốt
                    Colors.white.withOpacity(0.7), // Trắng mờ
                    Colors.white, // Trắng đậm hơn
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formSignInKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Đăng nhập",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Nhập email',
                        hintStyle: const TextStyle(color: Colors.black26),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        hintText: 'Nhập Password',
                        hintStyle: const TextStyle(color: Colors.black26),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => {},
                          child: const Text(
                            'Quên mật khẩu?',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Chưa có tài khoản?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF416FDF),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 17.0),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     iconTheme: const IconThemeData(color: Colors.white),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //   ),
  }
}
