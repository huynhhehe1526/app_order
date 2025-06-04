import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/sign_in.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({super.key, this.buttonText, this.ontap, this.color, this.textColor});
  final String? buttonText;
  final Widget? ontap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (ontap != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ontap!));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: color ?? Colors.blue,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(50)),
        ),
        child: Text(
          buttonText ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.white, 
          ),
        ),
      ),
    );
  }
}
