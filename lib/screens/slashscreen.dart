import 'package:dt02_nhom09/screens/login_screen.dart';
import 'package:dt02_nhom09/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:dt02_nhom09/screens/menu.dart';
import 'package:dt02_nhom09/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  int dotCount = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        dotCount = (dotCount + 1) % 4;
      });
    });
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color.fromARGB(255, 26, 188, 224),
        //       Color.fromARGB(255, 164, 23, 234),
        //       Color.fromARGB(255, 235, 53, 150),
        //     ],
        //     begin: Alignment.centerLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/Why-is-Good-Lighting-Important-in-a-Restaurant-scaled.webp',
            ),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: _controller,
                child: Icon(
                  Icons.restaurant_menu,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to the App Order${'.' * dotCount}',
                style: GoogleFonts.timmana(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Đặt món nhanh qua ứng dụng tiện lợi!',
                style: GoogleFonts.grenze(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              // CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
