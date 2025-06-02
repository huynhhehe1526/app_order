import 'package:dt02_nhom09/screens/shiftListScreen.dart';
import 'package:flutter/material.dart';
class SelectShiftRoleScreen extends StatelessWidget {
  const SelectShiftRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xem ca làm việc hôm nay')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.people_alt_outlined),
              label: const Text('Phục vụ'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ShiftListScreen(role: 'Nhân viên')),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.restaurant),
              label: const Text('Bếp'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ShiftListScreen(role: 'Bếp')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
