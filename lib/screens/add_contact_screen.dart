import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../repositories/contact_repository.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _repository = ContactRepository();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedGroup = 'Gia đình';
  String _selectedGender = 'Nam';
  bool _isFavorite = false;

  String? _nameError;
  String? _phoneError;

  final List<String> _groups = ['Gia đình', 'Bạn bè', 'Công việc', 'Khác'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final note = _noteController.text.trim();

    setState(() {
      _nameError = null;
      _phoneError = null;
    });

    bool hasError = false;

    // 1. Kiểm tra không được để trống họ tên
    if (name.isEmpty) {
      setState(() {
        _nameError = 'Họ và tên không được để trống!';
      });
      hasError = true;
    }

    // 2. Kiểm tra số điện thoại: đúng 10 số và bắt đầu bằng số 0
    final phoneRegex = RegExp(r'^0[0-9]{9}$');
    if (!phoneRegex.hasMatch(phone)) {
      setState(() {
        _phoneError = 'Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0!';
      });
      hasError = true;
    } else if (_repository.isPhoneExists(phone)) {
      // 3. Kiểm tra trùng lặp số điện thoại
      setState(() {
        _phoneError = 'Số điện thoại đã tồn tại trong danh bạ!';
      });
      hasError = true;
    }

    if (hasError) return;

    // Tạo đối tượng Contact mới và lưu vào Repository
    final newContact = Contact(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      phone: phone,
      group: _selectedGroup,
      gender: _selectedGender,
      isFavorite: _isFavorite,
      note: note,
    );

    _repository.addContact(newContact);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã thêm liên hệ thành công!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A56DB),
        foregroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Thêm liên hệ mới',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Họ và tên
            const Text(
              'Họ và tên *',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Nhập họ và tên (VD: Nguyễn Văn An)',
                errorText: _nameError,
                prefixIcon: const Icon(Icons.person_outline),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 2. Số điện thoại
            const Text(
              'Số điện thoại *',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: 'Nhập 10 số bắt đầu bằng 0',
                errorText: _phoneError,
                counterText: '',
                prefixIcon: const Icon(Icons.phone_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 3. Nhóm
            const Text(
              'Nhóm',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _selectedGroup,
              items: _groups.map((group) {
                return DropdownMenuItem(
                  value: group,
                  child: Text(group),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedGroup = val;
                  });
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.group_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 4. Giới tính
            const Text(
              'Giới tính',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Nam', label: Text('Nam'), icon: Icon(Icons.male)),
                  ButtonSegment(value: 'Nữ', label: Text('Nữ'), icon: Icon(Icons.female)),
                  ButtonSegment(value: 'Khác', label: Text('Khác'), icon: Icon(Icons.person_outline)),
                ],
                selected: {_selectedGender},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    _selectedGender = newSelection.first;
                  });
                },
              ),
            ),
            const SizedBox(height: 14),

            // 5. Yêu thích
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Thêm vào danh sách yêu thích',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              value: _isFavorite,
              activeColor: const Color(0xFFF59E0B),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (val) => setState(() => _isFavorite = val ?? false),
            ),
            const SizedBox(height: 14),

            // 6. Ghi chú
            const Text(
              'Ghi chú',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập ghi chú bổ sung (không bắt buộc)...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // 7. Nút Lưu
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A56DB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                ),
                child: const Text(
                  'LƯU LIÊN HỆ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
