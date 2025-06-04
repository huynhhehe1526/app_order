//test UI
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

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    _areas = await _db.getAllAreas();
    if (_areas.isEmpty) return;

    _tabController = TabController(length: _areas.length, vsync: this)
      ..addListener(() async {
        if (_tabController.indexIsChanging) return;
        await _loadTables(_areas[_tabController.index].id!);
      });

    await _loadTables(_areas.first.id!);
  }

  Future<void> _loadTables(int areaId) async {
    setState(() => _loading = true);
    _tables = await _db.getTablesWithAreaNameByAreaId(areaId);
    setState(() => _loading = false);
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Trống':
        return Colors.green.shade600;
      case 'Đã đặt':
        return Colors.orange.shade700;
      case 'Đang dùng':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade400;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Trống':
        return Icons.chair_alt;
      case 'Đã đặt':
        return Icons.event_available_outlined;
      case 'Đang dùng':
        return Icons.fastfood;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bàn theo khu vực'),
        backgroundColor: Colors.teal.shade700,
        bottom:
            _areas.isEmpty
                ? null
                : TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  // indicatorColor: Colors.white,
                  indicatorColor: Colors.yellow, 
                  labelColor: Colors.yellow, 
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  tabs: _areas.map((e) => Tab(text: e.name)).toList(),
                ),
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _tables.isEmpty
              ? const Center(
                child: Text(
                  'Không có bàn trong khu vực này',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: GridView.builder(
                  itemCount: _tables.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (_, index) {
                    final table = _tables[index];
                    final statusColor = _statusColor(table.status);
                    final statusIcon = _statusIcon(table.status);

                    return Material(
                      borderRadius: BorderRadius.circular(16),
                      elevation: 6,
                      shadowColor: statusColor.withOpacity(0.4),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          // TODO: thêm hành động khi bấm vào bàn
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bàn số & icon status ở trên cùng
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Bàn số ${table.id}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Icon(
                                    statusIcon,
                                    color: statusColor,
                                    size: 28,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Khu vực & số ghế
                              Text(
                                'Khu vực: ${table.areaName}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Số ghế: ${table.seatCount}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),

                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${(table.price ?? 0).toStringAsFixed(0)}đ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      table.status,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
