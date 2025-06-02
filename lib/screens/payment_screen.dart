import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> order;
  const PaymentScreen({super.key, required this.order});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<Map<String, String>> banks = [
    {
      'name': 'MB Bank',
      'logo': 'assets/logo/logo_mbbank.png',
      'account': '123 456 789 012',
      'receiver': 'Công ty MB Bank',
    },
    {
      'name': 'Vietcombank',
      'logo': 'assets/logo/logo_vcbank.png',
      'account': '111 222 333 444',
      'receiver': 'Công ty VietComBank',
    },
    {
      'name': 'TPBank',
      'logo': 'assets/logo/logo_tpbank.jpg',
      'account': '999 888 777 666',
      'receiver': 'Công ty TPBank',
    },
    {
      'name': 'ACB',
      'logo': 'assets/logo/logo_acb.png',
      'account': '555 444 333 222',
      'receiver': 'Công ty ACB',
    },
    {
      'name': 'BIDV',
      'logo': 'assets/logo/logo_bidv.jpg',
      'account': '111 888 222 555',
      'receiver': 'Công ty BIDV',
    },
    {
      'name': 'Agribank',
      'logo': 'assets/logo/logo_argibank.webp',
      'account': '123 234 345 456',
      'receiver': 'Công ty Agribank',
    },
    {
      'name': 'VietinBank',
      'logo': 'assets/logo/logo_vettinbank.webp',
      'account': '234 456 567 789',
      'receiver': 'Công ty VietTinbank',
    },
    {
      'name': 'Techcombank',
      'logo': 'assets/logo/logo_techcombank.jpg',
      'account': '345 567 678 789',
      'receiver': 'Công ty TechComBank',
    },
  ];

  String paymentMethod = 'qr';
  String selectedBank = 'MB Bank';

  // Người gửi
  final TextEditingController senderAccCtrl = TextEditingController();
  final TextEditingController senderNameCtrl = TextEditingController();

  /* ---------- THÔNG TIN NGƯỜI NHẬN (cố định) ---------- */
  late String receiverAccount;
  late String receiverName;

  /* ---------- NỘI DUNG CK (auto) ---------- */
  String get transferNote =>
      senderNameCtrl.text.isEmpty ? '' : '${senderNameCtrl.text} chuyển khoản';

  @override
  void initState() {
    super.initState();
    senderNameCtrl.addListener(() => setState(() {}));
    final bank = banks.firstWhere((b) => b['name'] == selectedBank);
    receiverAccount = bank['account']!;
    receiverName = bank['receiver']!;
  }

  @override
  void dispose() {
    senderAccCtrl.dispose();
    senderNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final amount = widget.order['total'];
    // final num amount = widget.order['total'] as num;
    final double amount =
        widget.order['total'] is int
            ? (widget.order['total'] as int).toDouble()
            : widget.order['total'] as double;

    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán chuyển khoản')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Chọn hình thức thanh toán',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                  label: const Text('QR Code'),
                  selected: paymentMethod == 'qr',
                  onSelected: (_) => setState(() => paymentMethod = 'qr'),
                ),
                ChoiceChip(
                  label: const Text('Số tài khoản'),
                  selected: paymentMethod == 'account',
                  onSelected: (_) => setState(() => paymentMethod = 'account'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /* ---------- PHƯƠNG THỨC CHUYỂN KHOẢN---------- */
            if (paymentMethod == 'qr')
              _buildQR(amount)
            else
              _buildAccount(amount),

            const Spacer(),

            /* ---------- BTN XÁC NHẬN ---------- */
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleConfirm,
                child: const Text('Xác nhận thanh toán'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ------------------------------------------------------------------ */
  /*                           QR SECTION                               */
  /* ------------------------------------------------------------------ */
  Widget _buildQR(double amount) => Column(
    children: [
      const Text(
        'Quét mã QR bên dưới để thanh toán:',
        style: TextStyle(fontSize: 16),
      ),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text('QR Code', style: TextStyle(fontSize: 20)),
        ),
      ),
      const SizedBox(height: 12),
      Text(
        'Số tiền: $amountđ',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ],
  );

  /* ------------------------------------------------------------------ */
  /*                        ACCOUNT SECTION                             */
  /* ------------------------------------------------------------------ */
  Widget _buildAccount(double amount) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Chọn ngân hàng', style: TextStyle(fontSize: 16)),
      const SizedBox(height: 10),

      /* ---- GRID CHỌN NGÂN HÀNG ---- */
      SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: banks.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            final bank = banks[i];
            final isSel = selectedBank == bank['name'];
            return GestureDetector(
              // onTap: () => setState(() => selectedBank = bank['name']!),
              onTap: () {
                setState(() {
                  selectedBank = bank['name']!;
                  receiverAccount = bank['account']!;
                  receiverName = bank['receiver']!;
                });
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSel ? Colors.blue : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(bank['logo']!),
                      radius: 30,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bank['name']!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 18),

      /* ---- NGƯỜI GỬI ---- */
      const Text(
        'Thông tin người gửi',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: senderAccCtrl,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Số tài khoản người gửi',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: senderNameCtrl,
        decoration: const InputDecoration(
          labelText: 'Họ tên người gửi',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 18),

      /* ---- NGƯỜI NHẬN ---- */
      const Text(
        'Thông tin người nhận',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 8),
      _readonlyField('Số tài khoản nhận', receiverAccount),
      const SizedBox(height: 8),
      _readonlyField('Tên người nhận', receiverName),
      const SizedBox(height: 8),
      _readonlyField('Nội dung chuyển khoản', transferNote),
      const SizedBox(height: 10),

      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Số tiền cần chuyển: $amountđ',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );

  Widget _readonlyField(String label, String value) {
    return TextField(
      controller: TextEditingController(text: value),
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  /* ------------------------------------------------------------------ */
  /*                        CONFIRM                                     */
  /* ------------------------------------------------------------------ */
  void _handleConfirm() {
    if (paymentMethod == 'account' &&
        (senderAccCtrl.text.trim().isEmpty ||
            senderNameCtrl.text.trim().isEmpty)) {
      toastification.show(
        context: context,
        title: Text('Vui lòng điền đầy đủ thông tin người gửi'),
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.info,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.topRight,
        icon: const Icon(Icons.check_circle),
        primaryColor: Colors.lightBlue,
      );
      return;
    }
    toastification.show(
      context: context,
      title: Text('Thanh toán thành công!'),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topRight,
      icon: const Icon(Icons.check_circle),
      primaryColor: Colors.green,
    );
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
    });
  }
}
