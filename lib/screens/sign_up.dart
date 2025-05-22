import 'package:dt02_nhom09/screens/custom_welcome.dart';
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/sign_up.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final _maGVController = TextEditingController();
  final _passwordController = TextEditingController();
  final _tenGVController = TextEditingController();

  bool rememberpass = true;
  @override
  void dispose() {
    _maGVController.dispose();
    _tenGVController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     iconTheme: const IconThemeData(color: Colors.white),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //   ),
    //   body: Stack(
    //     children: [
    //       Image.asset(
    //         'assets/images/hinh-nen-may-tinh-4k-7.jpg',
    //         fit: BoxFit.cover,
    //         height: double.infinity,
    //         width: double.infinity,
    //       ),
    //       Center(
    //         child: Container(
    //           margin: const EdgeInsets.symmetric(horizontal: 25),
    //           padding: const EdgeInsets.all(20),
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               begin: Alignment.centerRight,
    //               end: Alignment.centerLeft,
    //               colors: [
    //                 Colors.white.withOpacity(0.0),
    //                 Colors.white.withOpacity(0.7),
    //                 Colors.white,
    //               ],
    //             ),
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           child: Form(
    //             key: _formSignInKey,
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 const Text(
    //                   'Đăng ký',
    //                   style: TextStyle(
    //                     fontSize: 26,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.blueAccent,
    //                   ),
    //                 ),
    //                 //Nội dung form
    //                 TextFormField(
    //                   controller: _maGVController,
    //                   validator: (value) {
    //                     if (value == null || value.isEmpty) {
    //                       return "Vui lòng nhập mã giảng viên";
    //                     }
    //                     return null;
    //                   },
    //                   decoration: InputDecoration(
    //                     labelText: 'MaGV',
    //                     hintText: 'Nhập MAGV',
    //                     hintStyle: TextStyle(color: Colors.black26),
    //                     border: OutlineInputBorder(
    //                       borderSide: const BorderSide(color: Colors.black12),
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     enabledBorder: OutlineInputBorder(
    //                       borderSide: const BorderSide(color: Colors.black12),
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(height: 30),
    //                 //tên giảng viên
    //                 TextFormField(
    //                   controller: _tenGVController,
    //                   validator: (value) {
    //                     if (value == null || value.isEmpty) {
    //                       return "Vui lòng nhập tên giảng viên";
    //                     }
    //                     return null;
    //                   },
    //                   decoration: InputDecoration(
    //                     labelText: 'Ten GV',
    //                     hintText: 'Vui lòng nhập tên giảng viên',
    //                     hintStyle: TextStyle(color: Colors.black26),
    //                     border: OutlineInputBorder(
    //                       borderSide: const BorderSide(color: Colors.black12),
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     enabledBorder: OutlineInputBorder(
    //                       borderSide: const BorderSide(color: Colors.black12),
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(height: 30),
    //                 TextFormField(
    //                   controller: _passwordController,
    //                   obscureText: true,
    //                   obscuringCharacter: '*',
    //                   validator: (value) {
    //                     if (value == null || value.isEmpty) {
    //                       return "Vui lòng nhập mật khẩu";
    //                     }
    //                     return null;
    //                   },
    //                   decoration: InputDecoration(
    //                     labelText: 'Password',
    //                     hintText: 'Nhập mật khẩu',
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                       borderSide: const BorderSide(color: Colors.black12),
    //                     ),
    //                     enabledBorder: OutlineInputBorder(
    //                       borderSide: const BorderSide(color: Colors.black12),
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(height: 30),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Checkbox(
    //                       value: rememberpass,
    //                       onChanged: (bool? value) {
    //                         setState(() {
    //                           rememberpass = value!;
    //                         });
    //                       },
    //                       activeColor: Color(0xFF416FDF),
    //                     ),
    //                     const Text(
    //                       'Remember me',
    //                       style: TextStyle(color: Colors.black45),
    //                     ),
    //                   ],
    //                 ),

    //                 const SizedBox(height: 17),
    //                 ElevatedButton(
    //                   onPressed: () async {
    //                     // if (_formSignInKey.currentState!.validate() &&
    //                     //     rememberpass) {
    //                     //   String maGV = _maGVController.text;
    //                     //   String password = _passwordController.text;
    //                     //   String tenGV = _tenGVController.text;

    //                     //   DatabasHelper dbHelper = DatabasHelper();
    //                     //   final existingUser = await dbHelper.getUserByMaGV(
    //                     //     maGV,
    //                     //   );

    //                     //   if (existingUser != null) {
    //                     //     ScaffoldMessenger.of(context).showSnackBar(
    //                     //       const SnackBar(
    //                     //         content: Text(
    //                     //           'MaGV này đã có trong hệ thống. Vui lòng nhập thông tin đăng ký khác',
    //                     //         ),
    //                     //       ),
    //                     //     );
    //                     //     return;
    //                     //   }

    //                     //   await dbHelper.insertTaiKhoan(
    //                     //     TaiKhoan(
    //                     //       maGV: maGV,
    //                     //       tenGV: tenGV,
    //                     //       matKhau: password,
    //                     //     ),
    //                     //   );
    //                     //   ScaffoldMessenger.of(context).showSnackBar(
    //                     //     const SnackBar(content: Text('Đăng ký thành công')),
    //                     //   );
    //                     //   Navigator.pushReplacement(
    //                     //     context,
    //                     //     MaterialPageRoute(
    //                     //       builder: (context) => const SigninScreen(),
    //                     //     ),
    //                     //   );
    //                     // } else if (!rememberpass) {
    //                     //   ScaffoldMessenger.of(context).showSnackBar(
    //                     //     const SnackBar(
    //                     //       content: Text(
    //                     //         'Vui lòng chọn click chọn nhớ mật khẩu để hoàn tất quá trình đăng ký!',
    //                     //       ),
    //                     //     ),
    //                     //   );
    //                     // }
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     backgroundColor: Colors.blue,
    //                     padding: const EdgeInsets.symmetric(
    //                       horizontal: 40,
    //                       vertical: 15,
    //                     ),
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                   ),
    //                   child: Text('Đăng ký', style: TextStyle(fontSize: 18)),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return CustomWelcome(
      child: Stack(
        children: [
          const Expanded(flex: 1, child: SizedBox(height: 10)),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.7),
                    Colors.white,
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
                      'Đăng ký',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    //Nội dung form
                    TextFormField(
                      controller: _maGVController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập mã giảng viên";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'MaGV',
                        hintText: 'Nhập MAGV',
                        hintStyle: TextStyle(color: Colors.black26),
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
                    //tên giảng viên
                    TextFormField(
                      controller: _tenGVController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập tên giảng viên";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Ten GV',
                        hintText: 'Vui lòng nhập tên giảng viên',
                        hintStyle: TextStyle(color: Colors.black26),
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
                          return "Vui lòng nhập mật khẩu";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Nhập mật khẩu',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: rememberpass,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberpass = value!;
                            });
                          },
                          activeColor: Color(0xFF416FDF),
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),

                    const SizedBox(height: 17),
                    ElevatedButton(
                      onPressed: () async {
                        // if (_formSignInKey.currentState!.validate() &&
                        //     rememberpass) {
                        //   String maGV = _maGVController.text;
                        //   String password = _passwordController.text;
                        //   String tenGV = _tenGVController.text;

                        //   DatabasHelper dbHelper = DatabasHelper();
                        //   final existingUser = await dbHelper.getUserByMaGV(
                        //     maGV,
                        //   );

                        //   if (existingUser != null) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text(
                        //           'MaGV này đã có trong hệ thống. Vui lòng nhập thông tin đăng ký khác',
                        //         ),
                        //       ),
                        //     );
                        //     return;
                        //   }

                        //   await dbHelper.insertTaiKhoan(
                        //     TaiKhoan(
                        //       maGV: maGV,
                        //       tenGV: tenGV,
                        //       matKhau: password,
                        //     ),
                        //   );
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Đăng ký thành công')),
                        //   );
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const SigninScreen(),
                        //     ),
                        //   );
                        // } else if (!rememberpass) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content: Text(
                        //         'Vui lòng chọn click chọn nhớ mật khẩu để hoàn tất quá trình đăng ký!',
                        //       ),
                        //     ),
                        //   );
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Đăng ký', style: TextStyle(fontSize: 18)),
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
