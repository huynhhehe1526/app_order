// import 'package:flutter/material.dart';

// class TableScreen extends StatefulWidget {
//   const TableScreen({super.key});

//   @override
//   _TableScreenState createState() => _TableScreenState();
// }

// // const TableScreen({super.key});
// class _TableScreenState extends State<TableScreen> {
//   final List<String> tables = ["Bàn 1", "Bàn 2", "Bàn 3", "Bàn 4"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chọn Bàn")),
//       body: GridView.builder(
//         padding: EdgeInsets.all(10),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1.2,
//         ),
//         itemCount: tables.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, '/menu', arguments: tables[index]);
//             },
//             child: Card(
//               color: Colors.green[100],
//               child: Center(
//                 child: Text(tables[index], style: TextStyle(fontSize: 20)),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//tets giao diện
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/screens/data/mock_data.dart';

class TableScreen extends StatelessWidget {
  // final List<Map<String, String>> tables = [
  //   {
  //     'id': '1',
  //     'seat_count': '4',
  //     'status': 'Trống',
  //     'area_name': 'Ngoài trời',
  //     'price': '150000',
  //   },
  //   {
  //     'id': '2',
  //     'seat_count': '2',
  //     'status': 'Đã đặt',
  //     'area_name': 'Trong nhà',
  //     'price': '100000',
  //   },
  //   {
  //     'id': '3',
  //     'seat_count': '6',
  //     'status': 'Trống',
  //     'area_name': 'Sự kiện',
  //     'price': '300000',
  //   },
  //   {
  //     'id': '4',
  //     'seat_count': '8',
  //     'status': 'Đang dùng',
  //     'area_name': 'Phòng chờ',
  //     'price': '200000',
  //   },
  //   {
  //     'id': '5',
  //     'seat_count': '4',
  //     'status': 'Trống',
  //     'area_name': 'Trong nhà',
  //     'price': '120000',
  //   },
  // ];


  Color getStatusColor(String status) {
    switch (status) {
      case 'Trống':
        return Colors.green;
      case 'Đã đặt':
        return Colors.orange;
      case 'Đang dùng':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Trống':
        return Icons.check_circle;
      case 'Đã đặt':
        return Icons.schedule;
      case 'Đang dùng':
        return Icons.dining;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách bàn'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: tables.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            childAspectRatio: 3 / 2.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final table = tables[index];
            final statusColor = getStatusColor(table['status']!);
            final statusIcon = getStatusIcon(table['status']!);

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: statusColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bàn số ${table['id']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text("Khu vực: ${table['area_name']}"),
                    Text("Số ghế: ${table['seat_count']}"),
                    Text("Giá: ${table['price']}đ"),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 16, color: statusColor),
                          SizedBox(width: 4),
                          Text(
                            table['status']!,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
