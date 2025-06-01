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
// import 'package:flutter/material.dart';
// import 'package:dt02_nhom09/screens/data/mock_data.dart';

// class TableScreen extends StatelessWidget {

//   Color getStatusColor(String status) {
//     switch (status) {
//       case 'Trống':
//         return Colors.green;
//       case 'Đã đặt':
//         return Colors.orange;
//       case 'Đang dùng':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   IconData getStatusIcon(String status) {
//     switch (status) {
//       case 'Trống':
//         return Icons.check_circle;
//       case 'Đã đặt':
//         return Icons.schedule;
//       case 'Đang dùng':
//         return Icons.dining;
//       default:
//         return Icons.help;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Danh sách bàn'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GridView.builder(
//           itemCount: tables.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // 2 columns
//             childAspectRatio: 3 / 2.5,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemBuilder: (context, index) {
//             final table = tables[index];
//             final statusColor = getStatusColor(table['status']!);
//             final statusIcon = getStatusIcon(table['status']!);

//             return Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(color: statusColor, width: 2),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Bàn số ${table['id']}",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text("Khu vực: ${table['area_name']}"),
//                     Text("Số ghế: ${table['seat_count']}"),
//                     Text("Giá: ${table['price']}đ"),
//                     SizedBox(height: 8),
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                       decoration: BoxDecoration(
//                         color: statusColor.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(statusIcon, size: 16, color: statusColor),
//                           SizedBox(width: 4),
//                           Text(
//                             table['status']!,
//                             style: TextStyle(
//                               color: statusColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//testtttttttttt'
import 'package:flutter/material.dart';
import 'package:dt02_nhom09/db/db_helper.dart';
import 'package:dt02_nhom09/class/area.dart';
import 'package:dt02_nhom09/class/table_model.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen>
    with SingleTickerProviderStateMixin {
  final _db = DatabaseHelper();
  late TabController _tabController;

  List<Area> _areas = [];
  List<TableModel> _tables = [];
  bool _loading = true;
  String getAreaNameById(int areaId) {
    final area = _areas.firstWhere(
      (a) => a.id == areaId,
      orElse: () => Area(id: 0, name: 'Không rõ'),
    );
    return area.name;
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    // Lấy danh sách khu vực
    _areas = await _db.getAllAreas();
    if (_areas.isEmpty) return;

    _tabController = TabController(length: _areas.length, vsync: this)
      ..addListener(() async {
        if (_tabController.indexIsChanging) return;
        await _loadTables(_areas[_tabController.index].id!);
      });

    // Tải bàn của khu vực đầu tiên
    await _loadTables(_areas.first.id!);
  }

  Future<void> _loadTables(int areaId) async {
    setState(() => _loading = true);
    // _tables = await _db.getTablesByArea(areaId);getTablesWithAreaNameByAreaId
    _tables = await _db.getTablesWithAreaNameByAreaId(areaId);
    setState(() => _loading = false);
  }

  // ---------- Helpers ----------
  Color _statusColor(String status) {
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

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Trống':
        return Icons.check_circle;
      case 'Đã đặt':
        return Icons.schedule;
      case 'Đang dùng':
        return Icons.restaurant; // dining bị deprecate
      default:
        return Icons.help;
    }
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bàn theo khu vực'),
        backgroundColor: Colors.teal,
        bottom:
            _areas.isEmpty
                ? null
                : TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: _areas.map((e) => Tab(text: e.name)).toList(),
                ),
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _tables.isEmpty
              ? const Center(child: Text('Không có bàn trong khu vực này'))
              : Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: _tables.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    final table = _tables[index];
                    final color = _statusColor(table.status);
                    final icon = _statusIcon(table.status);

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: color, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bàn số ${table.id}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Khu vực: ${table.areaName}'),
                            Text('Số ghế: ${table.seatCount}'),
                            // Text('Giá: ${table.price.toStringAsFixed(0)}đ'),
                            Text(
                              'Giá: ${(table.price ?? 0).toStringAsFixed(0)}đ',
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(icon, size: 16, color: color),
                                  const SizedBox(width: 4),
                                  Text(
                                    table.status,
                                    style: TextStyle(
                                      color: color,
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
