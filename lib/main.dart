// import 'package:dt02_nhom09/screens/login_screen.dart';
import 'package:dt02_nhom09/screens/chef_screen.dart';
import 'package:dt02_nhom09/screens/home.dart';
import 'package:dt02_nhom09/screens/login_screen.dart';
import 'package:dt02_nhom09/screens/menu.dart';
import 'package:dt02_nhom09/screens/modalCrud/addMenu.dart';
import 'package:dt02_nhom09/screens/modalCrud/addOrderScreen.dart';
import 'package:dt02_nhom09/screens/order_detail_screen.dart';
import 'package:dt02_nhom09/screens/orderscreen.dart';
import 'package:dt02_nhom09/screens/payment_screen.dart';
import 'package:dt02_nhom09/screens/profile_screen.dart';
import 'package:dt02_nhom09/screens/selectShiftRoleScreen.dart';
import 'package:dt02_nhom09/screens/shiftListScreen.dart';
import 'package:dt02_nhom09/screens/sign_in.dart';
import 'package:dt02_nhom09/screens/slashscreen.dart';
import 'package:dt02_nhom09/screens/table_screen.dart';
import 'package:dt02_nhom09/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/order_mode.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:dt02_nhom09/screens/employee_management.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().insertDefaultManager();

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
        '/': (context) => SplashScreen(),
        // '/': (context) => WelcomeScreen(),
        '/login': (context) => SigninScreen(),
        '/tables': (context) => TableScreen(),
        // '/menu': (context) => MenuScreen(),
        // '/add_menu': (context) => AddMenuScreen(),
        '/shift-role-select': (_) => const SelectShiftRoleScreen(),
        // '/shift-list': (_) => const ShiftListScreen(), // nhận arguments
        // '/chef':(context) => ChefScreen(chefId: chefId)
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
        else if (settings.name == '/manage') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (_) => EmployeeManagementScreen(
                  currentUserRole: args['currentUserRole'],
                ),
          );
        } else if (settings.name == '/add_order') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (_) => AddOrderScreen(
                  mode: args['mode'] as OrderMode,
                  id: args['id'] as int,
                  name: args['fullname'] ?? '',
                  role: args['role'] ?? '',
                ),
          );
        } else if (settings.name == '/order') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (_) => OrderScreen(
                  role: args['role'] as String,
                  id: args['id'] as int,
                  name: args['fullname'] as String,
                ),
          );
        } else if (settings.name == '/profile') {
          final id = settings.arguments as int;
          return MaterialPageRoute(builder: (_) => ProfileScreen(id: id));
        } else if (settings.name == '/chef') {
          final id = settings.arguments as int;
          return MaterialPageRoute(builder: (_) => ChefScreen(chefId: id));
        } else if (settings.name == '/shift-list') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => ShiftListScreen(userId: args['userId']),
          );
        } else if (settings.name == '/add_menu') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => AddMenuScreen(role: args['role'] ?? ''),
          );
        } else if (settings.name == '/menu') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => MenuScreen(role: args['role'] ?? ''),
          );
        }
        return null;
      },
    );
  }
}
