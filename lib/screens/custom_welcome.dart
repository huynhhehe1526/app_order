//giao diện
import 'dart:ui';
import 'package:flutter/material.dart';

class CustomWelcome extends StatelessWidget {
  const CustomWelcome({super.key, required this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/photo-1543007631-283050bb3e8c.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              // color: Colors.black.withOpacity(
              //   0.2,
              // ), // thêm overlay mờ đen nhẹ, bạn chỉnh opacity thoải mái
              color: const Color.fromARGB(255, 100, 4, 99).withOpacity(0.2),
            ),
          ),
          SafeArea(child: child!),
        ],
      ),
    );
  }
}

//test cuối
// import 'package:flutter/material.dart';

// class CustomWelcome extends StatelessWidget {
//   const CustomWelcome({super.key, required this.child});
//   final Widget? child;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/images/hinh-nen-may-tinh-4k-7.jpg',
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SafeArea(child: child!),
//         ],
//       ),
//     );
//   }
// }
