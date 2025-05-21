import 'package:flutter/material.dart';

class GirdItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onTap;

  const GirdItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon, SizedBox(height: 8), Text(title)],
      ),
    );
  }
}
