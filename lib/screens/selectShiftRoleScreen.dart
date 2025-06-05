import 'package:dt02_nhom09/screens/shiftListScreen.dart';
import 'package:flutter/material.dart';

class SelectShiftRoleScreen extends StatelessWidget {
  const SelectShiftRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xem ca làm việc hôm nay'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleButton(
              context,
              icon: Icons.people_alt_outlined,
              label: 'Phục vụ',
              role: 'Nhân viên',
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            _buildRoleButton(
              context,
              icon: Icons.restaurant,
              label: 'Bếp',
              role: 'Bếp',
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String role,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ShiftListScreen(role: role)),
            ),
      ),
    );
  }
}
