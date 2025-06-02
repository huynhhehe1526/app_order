//test
// import 'package:dt02_nhom09/screens/custom_welcome.dart';
// import 'package:flutter/material.dart';
// import 'package:dt02_nhom09/screens/home.dart';
// import 'package:dt02_nhom09/screens/sign_up.dart';
// import 'package:dt02_nhom09/class/user.dart';
// import 'package:dt02_nhom09/db/db_helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dt02_nhom09/screens/employee_management.dart';

// class SigninScreen extends StatefulWidget {
//   const SigninScreen({super.key});

//   @override
//   State<SigninScreen> createState() => _SigninScreenState();
// }

// class _SigninScreenState extends State<SigninScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final DatabaseHelper dbHelper = DatabaseHelper();

//   bool rememberPass = true;
//   bool _obscurePassword =
//       true; // Thêm biến theo dõi trạng thái ẩn/hiện mật khẩu

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSignin() async {
//     if (!_formKey.currentState!.validate()) return;

//     String email = _emailController.text.trim();
//     String password = _passwordController.text;

//     User? user = await dbHelper.getUserByEmail(email);

//     if (user == null) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Email chưa được đăng ký!'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     if (user.password != password) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Mật khẩu không đúng!'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Lưu SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('user_id', user.id ?? 0);
//     await prefs.setString('user_role', user.role);

//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Đăng nhập thành công!'),
//         backgroundColor: Colors.green,
//       ),
//     );

//     // Chuyển sang màn hình phù hợp với vai trò
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder:
//             (context) => HomeScreen(
//               id: user.id ?? 0,
//               name: user.fullname,
//               role: user.role,
//             ),
//       ),
//     );
//   }

//   void _showForgotPasswordDialog() {
//     final emailController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Quên mật khẩu'),
//           content: TextField(
//             controller: emailController,
//             decoration: const InputDecoration(labelText: 'Nhập email của bạn'),
//           ),
//           actions: [
//             TextButton(
//               child: const Text('Hủy'),
//               onPressed: () => Navigator.of(dialogContext).pop(),
//             ),
//             TextButton(
//               child: const Text('Gửi'),
//               onPressed: () async {
//                 String email = emailController.text.trim();
//                 if (email.isEmpty) return;

//                 User? user = await dbHelper.getUserByEmail(email);
//                 Navigator.of(context).pop();

//                 if (user == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Email không tồn tại trong hệ thống'),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 } else {
//                   // Tạm thời hiện mật khẩu ra vì không có gửi email
//                   showDialog(
//                     context: context,
//                     builder:
//                         (BuildContext dialogContext) => AlertDialog(
//                           title: const Text("Mật khẩu của bạn là:"),
//                           content: Text(user.password),
//                           actions: [
//                             TextButton(
//                               child: const Text("Đóng"),
//                               onPressed:
//                                   () => Navigator.of(dialogContext).pop(),
//                             ),
//                           ],
//                         ),
//                   );
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomWelcome(
//       child: Stack(
//         children: [
//           const SizedBox(height: 10),
//           Center(
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 25),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.centerRight,
//                   end: Alignment.centerLeft,
//                   colors: [
//                     Colors.black.withOpacity(0.0),
//                     Colors.black.withOpacity(0.7),
//                     Colors.black,
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       'Sign In',
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.amber,
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: _emailController,
//                       style: const TextStyle(color: Colors.white),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Vui lòng nhập email";
//                         }
//                         if (!RegExp(
//                           r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                         ).hasMatch(value)) {
//                           return "Email không hợp lệ";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         labelStyle: const TextStyle(
//                           color: Color.fromARGB(255, 173, 129, 17),
//                         ),
//                         hintText: 'Nhập email',
//                         // hintStyle: const TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.black),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.black),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: _passwordController,
//                       style: const TextStyle(color: Colors.white),
//                       obscureText: _obscurePassword,
//                       obscuringCharacter: '*',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Vui lòng nhập mật khẩu";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         // labelStyle: const TextStyle(color: Colors.white),
//                         labelStyle: const TextStyle(
//                           color: Color.fromARGB(255, 173, 129, 17),
//                         ),
//                         hintText: 'Nhập mật khẩu',
//                         // hintStyle: const TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(color: Colors.black),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.black),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscurePassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Color(0xFFAD8111),
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Checkbox(
//                               value: rememberPass,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   rememberPass = value ?? false;
//                                 });
//                               },
//                               activeColor: const Color(0xFF416FDF),
//                             ),
//                             const Text(
//                               'Remember me',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                         GestureDetector(
//                           onTap: _showForgotPasswordDialog,
//                           child: const Text(
//                             'Quên mật khẩu?',
//                             style: TextStyle(
//                               color: Color.fromARGB(255, 173, 129, 17),
//                               fontWeight: FontWeight.bold,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 17),
//                     ElevatedButton(
//                       onPressed: _handleSignin,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromARGB(255, 173, 129, 17),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 40,
//                           vertical: 15,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Đăng nhập',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SignupScreen(),
//                           ),
//                         );
//                       },
//                       // child: const Text(
//                       //   'Bạn chưa có tài khoản? Đăng ký',
//                       //   style: TextStyle(color: Colors.white),
//                       // ),
//                       child: Text.rich(
//                         TextSpan(
//                           text: 'Bạn chưa có tài khoản? ',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ), // Màu chữ chung
//                           children: [
//                             TextSpan(
//                               text: 'Đăng ký',
//                               style: TextStyle(
//                                 color:
//                                     Colors
//                                         .blue, // 🎯 Màu xanh riêng cho chữ "Đăng ký"
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//test cuối
import 'package:dt02_nhom09/screens/custom_welcome.dart';
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/home.dart';
import 'package:dt02_nhom09/screens/sign_up.dart';
import 'package:dt02_nhom09/class/user.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper();

  bool rememberPass = true;
  bool _obscurePassword =
      true; // Thêm biến theo dõi trạng thái ẩn/hiện mật khẩu

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  void _loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('remembered_email');
    String? savedPassword = prefs.getString('remembered_password');

    if (savedEmail != null && savedPassword != null) {
      setState(() {
        _emailController.text = savedEmail;
        _passwordController.text = savedPassword;
        rememberPass = true;
      });
      // _handleSignin();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignin() async {
    if (!_formKey.currentState!.validate()) return;

    String email = _emailController.text.trim();
    String password = _passwordController.text;

    User? user = await dbHelper.getUserByEmail(email);

    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email chưa được đăng ký!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (user.password != password) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu không đúng!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Lưu SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id ?? 0);
    await prefs.setString('user_role', user.role);

    if (rememberPass) {
      await prefs.setString('remembered_email', email);
      await prefs.setString('remembered_password', password);
    } else {
      await prefs.remove('remembered_email');
      await prefs.remove('remembered_password');
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đăng nhập thành công!'),
        backgroundColor: Colors.green,
      ),
    );

    // Chuyển sang màn hình phù hợp với vai trò
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => HomeScreen(
              id: user.id ?? 0,
              name: user.fullname,
              role: user.role,
            ),
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Quên mật khẩu'),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Nhập email của bạn'),
          ),
          actions: [
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Gửi'),
              onPressed: () async {
                String email = emailController.text.trim();
                if (email.isEmpty) return;

                User? user = await dbHelper.getUserByEmail(email);
                Navigator.of(context).pop();

                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email không tồn tại trong hệ thống'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // Tạm thời hiện mật khẩu ra vì không có gửi email
                  showDialog(
                    context: context,
                    builder:
                        (BuildContext dialogContext) => AlertDialog(
                          title: const Text("Mật khẩu của bạn là:"),
                          content: Text(user.password),
                          actions: [
                            TextButton(
                              child: const Text("Đóng"),
                              onPressed:
                                  () => Navigator.of(dialogContext).pop(),
                            ),
                          ],
                        ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomWelcome(
      child: Stack(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.7),
                    Colors.black,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập email";
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return "Email không hợp lệ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 129, 17),
                        ),
                        hintText: 'Nhập email',
                        // hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: _obscurePassword,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập mật khẩu";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        // labelStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 129, 17),
                        ),
                        hintText: 'Nhập mật khẩu',
                        // hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xFFAD8111),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberPass,
                              onChanged: (bool? value) {
                                setState(() {
                                  rememberPass = value ?? false;
                                });
                              },
                              activeColor: const Color(0xFF416FDF),
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: _showForgotPasswordDialog,
                          child: const Text(
                            'Quên mật khẩu?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 173, 129, 17),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    ElevatedButton(
                      onPressed: _handleSignin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 173, 129, 17),
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
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      // child: const Text(
                      //   'Bạn chưa có tài khoản? Đăng ký',
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      child: Text.rich(
                        TextSpan(
                          text: 'Bạn chưa có tài khoản? ',
                          style: TextStyle(
                            color: Colors.white,
                          ), // Màu chữ chung
                          children: [
                            TextSpan(
                              text: 'Đăng ký',
                              style: TextStyle(
                                color:
                                    Colors
                                        .blue, // 🎯 Màu xanh riêng cho chữ "Đăng ký"
                                fontWeight: FontWeight.bold,
                              ),
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
        ],
      ),
    );
  }
}
