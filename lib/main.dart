// import 'package:dt02_nhom09/screens/login_screen.dart';
import 'package:dt02_nhom09/screens/home.dart';
import 'package:dt02_nhom09/screens/login_screen.dart';
import 'package:dt02_nhom09/screens/menu.dart';
import 'package:dt02_nhom09/screens/modalCrud/addOrderScreen.dart';
import 'package:dt02_nhom09/screens/order_detail_screen.dart';
import 'package:dt02_nhom09/screens/orderscreen.dart';
import 'package:dt02_nhom09/screens/payment_screen.dart';
import 'package:dt02_nhom09/screens/profile_screen.dart';
import 'package:dt02_nhom09/screens/sign_in.dart';
import 'package:dt02_nhom09/screens/slashscreen.dart';
import 'package:dt02_nhom09/screens/table_screen.dart';
import 'package:dt02_nhom09/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/order_mode.dart';
// import 'package:dt02_nhom09/screens/home.dart';

// void main() {
//   runApp(MaterialApp(home: SplashScreen(), debugShowCheckedModeBanner: false));
// }
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý order nhà hàng',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/': (context) => SplashScreen(),
        '/': (context) => WelcomeScreen(),
        '/login': (context) => SigninScreen(),
        '/tables': (context) => TableScreen(),
        '/menu': (context) => MenuScreen(),
        // '/order': (context) => OrderScreen(),
        // '/payment': (context) => PaymentScreen(),
        // '/order_detail': (context) => OrderDetailScreen(),
        '/order_detail': (context) {
          final order =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return OrderDetailScreen(order: order);
        },
        '/payment': (context) {
          final order =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return PaymentScreen(order: order);
        },
        // '/add_order': (context) => AddOrderScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (_) => HomeScreen(
                  id: int.parse(args['id']!),
                  name: args['fullname']!,
                  role: args['role']!,
                ),
          );
        }
        // else if (settings.name == '/add_order') {
        //   final args = settings.arguments as Map<String, dynamic>?;
        //   final OrderMode mode = args?['mode'] ?? OrderMode.customerOnline;
        //   final String name = args?['fullname'] ?? '';
        //   final String role = args?['role'] ?? '';
        //   return MaterialPageRoute(
        //     builder: (_) => AddOrderScreen(mode: mode, name: name, role: role),
        //   );
        // }
        else if (settings.name == '/add_order') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (_) => AddOrderScreen(
                  mode: args['mode'] as OrderMode,
                  name: args['fullname'] ?? '',
                  role: args['role'] ?? '',
                ),
          );
        } else if (settings.name == '/order') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (_) => OrderScreen(
                  // id: int.parse(args['id']!),
                  // name: args['fullname']!,
                  // role: args['role']!,
                  role: args['role'] as String,
                  id: args['id'] as int,
                  name: args['fullname'] as String,
                ),
          );
        } else if (settings.name == '/profile') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(id: int.parse(args['id']!)),
          );
        }
        return null;
      },
    );
  }
}
