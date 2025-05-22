// users
final List<Map<String, dynamic>> users = [
  {
    'id': 1,
    'username': 'quanly01',
    'password': '123456',
    'fullname': 'Nguyễn Văn Quản',
    'role': 'Quản lý',
    'phone': '0911111111',
    'email': 'quanly@gmail.com',
    'address': '123 Quản Lý, TP.HCM',
  },
  {
    'id': 2,
    'username': 'phucvu01',
    'password': '123456',
    'fullname': 'Trần Thị Phục',
    'role': 'Nhân viên phục vụ',
    'phone': '0922222222',
    'email': 'phucvu@gmail.com',
    'address': '456 Phục Vụ, TP.HCM',
  },
  {
    'id': 3,
    'username': 'bep01',
    'password': '123456',
    'fullname': 'Lê Văn Bếp',
    'role': 'Bếp',
    'phone': '0933333333',
    'email': 'bep@gmail.com',
    'address': '789 Bếp Nấu, TP.HCM',
  },
  {
    'id': 4,
    'username': 'khach01',
    'password': '123456',
    'fullname': 'Phạm Khách Hàng',
    'role': 'Khách hàng',
    'phone': '0944444444',
    'email': 'khach@gmail.com',
    'address': '101 Khách, TP.HCM',
  },
  {
    'id': 5,
    'username': 'phucvu02',
    'password': '123456',
    'fullname': 'Ngô Minh Phục',
    'role': 'Nhân viên phục vụ',
    'phone': '0955555555',
    'email': 'phucvu2@gmail.com',
    'address': '102 Phục Vụ, TP.HCM',
  },
];

// shift
final List<Map<String, dynamic>> shifts = [
  {'id': 1, 'shiftname': 'Ca sáng', 'start_time': '07:00', 'end_time': '11:00'},
  {
    'id': 2,
    'shiftname': 'Ca chiều',
    'start_time': '12:00',
    'end_time': '17:30',
  },
  {'id': 3, 'shiftname': 'Ca tối', 'start_time': '18:00', 'end_time': '23:00'},
  {
    'id': 4,
    'shiftname': 'Ca đặc biệt',
    'start_time': '10:00',
    'end_time': '14:00',
  },
  {
    'id': 5,
    'shiftname': 'Ca khuya',
    'start_time': '23:00',
    'end_time': '03:00',
  },
];
// areas
final List<Map<String, dynamic>> areas = [
  {'id': 1, 'name': 'Ngoài trời'},
  {'id': 2, 'name': 'Trong nhà'},
  {'id': 3, 'name': 'Sự kiện'},
  {'id': 4, 'name': 'Phòng chờ'},
];
// tables (cập nhật lại area_name -> area_id)
final List<Map<String, dynamic>> tables = [
  {
    'id': 1,
    'seat_count': '4',
    'status': 'Trống',
    'area_id': 1, // Ngoài trời
    'price': '150000',
  },
  {
    'id': 2,
    'seat_count': '2',
    'status': 'Trống',
    'area_id': 2, // Trong nhà
    'price': '100000',
  },
  {
    'id': 3,
    'seat_count': '6',
    'status': 'Trống',
    'area_id': 3, // Sự kiện
    'price': '300000',
  },
  {
    'id': 4,
    'seat_count': '8',
    'status': 'Đang dùng',
    'area_id': 4, // Phòng chờ
    'price': '200000',
  },
  {
    'id': 5,
    'seat_count': '4',
    'status': 'Trống',
    'area_id': 2, // Trong nhà
    'price': '120000',
  },
];

// staffShiftAreas
final List<Map<String, dynamic>> staffShiftAreas = [
  {'id': 1, 'shift_id': 1, 'staff_id': 2, 'table_id': 1, 'date': '2025-05-22'},
  {'id': 2, 'shift_id': 2, 'staff_id': 5, 'table_id': 2, 'date': '2025-05-22'},
  {'id': 3, 'shift_id': 3, 'staff_id': 2, 'table_id': 3, 'date': '2025-05-23'},
  {'id': 4, 'shift_id': 1, 'staff_id': 5, 'table_id': 4, 'date': '2025-05-23'},
  {'id': 5, 'shift_id': 2, 'staff_id': 2, 'table_id': 5, 'date': '2025-05-24'},
];

// categories
final List<Map<String, dynamic>> categories = [
  {'id': 1, 'name': 'Món chính'},
  {'id': 2, 'name': 'Đồ uống'},
  {'id': 3, 'name': 'Món tráng miệng'},
  {'id': 4, 'name': 'Đồ chay'},
  {'id': 5, 'name': 'Đặc sản'},
];

// dishes
final List<Map<String, dynamic>> dishes = [
  {
    'id': 1,
    'name': 'Phở bò',
    'price': '50000',
    'image_url': 'pho.jpg',
    'category_id': 1,
    'status': 'Còn',
  },
  {
    'id': 2,
    'name': 'Trà sữa',
    'price': '30000',
    'image_url': 'trasua.jpg',
    'category_id': 2,
    'status': 'Còn',
  },
  {
    'id': 3,
    'name': 'Chè thái',
    'price': '25000',
    'image_url': 'chethai.jpg',
    'category_id': 3,
    'status': 'Sắp hết',
  },
  {
    'id': 4,
    'name': 'Bún chay',
    'price': '40000',
    'image_url': 'bunchay.jpg',
    'category_id': 4,
    'status': 'Còn',
  },
  {
    'id': 5,
    'name': 'Gà nướng mật ong',
    'price': '80000',
    'image_url': 'ganuong.jpg',
    'category_id': 5,
    'status': 'Hết',
  },
];

// orders
final List<Map<String, dynamic>> orders = [
  {
    'id': 1,
    'customer_id': 4,
    'staff_id': 2,
    'status': 'Chờ xử lý',
    'total_amount': '105000',
    'note': 'Tiền mặt',
  },
  {
    'id': 2,
    'customer_id': 4,
    'staff_id': 5,
    'status': 'Đang xử lý',
    'total_amount': '130000',
    'note': 'Chuyển khoản',
  },
  {
    'id': 3,
    'customer_id': 4,
    'staff_id': 2,
    'status': 'Đã thanh toán',
    'total_amount': '80000',
    'note': 'Momo',
  },
  {
    'id': 4,
    'customer_id': 4,
    'staff_id': 5,
    'status': 'Hủy',
    'total_amount': '0',
    'note': '---',
  },
  {
    'id': 5,
    'customer_id': 4,
    'staff_id': 2,
    'status': 'Đang tiến hành',
    'total_amount': '145000',
    'note': 'ZaloPay',
  },
];

// orderDetails
final List<Map<String, dynamic>> orderDetails = [
  {
    'id': 1,
    'order_id': 1,
    'dish_id': 1,
    'quantity': '1',
    'status': 'Đã đặt',
    'chef_id': 3,
  },
  {
    'id': 2,
    'order_id': 1,
    'dish_id': 2,
    'quantity': '1',
    'status': 'Đang chế biến',
    'chef_id': 3,
  },
  {
    'id': 3,
    'order_id': 2,
    'dish_id': 3,
    'quantity': '2',
    'status': 'Hoàn thành',
    'chef_id': 3,
  },
  {
    'id': 4,
    'order_id': 3,
    'dish_id': 5,
    'quantity': '1',
    'status': 'Đang chế biến',
    'chef_id': 3,
  },
  {
    'id': 5,
    'order_id': 5,
    'dish_id': 4,
    'quantity': '3',
    'status': 'Đã đặt',
    'chef_id': 3,
  },
];
