import 'package:flutter/material.dart';
import '../repositories/contact_repository.dart';
import '../widgets/contact_item.dart';
import 'add_contact_screen.dart';
import 'contact_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _repository = ContactRepository();

  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final contacts = _repository.contacts;
    final total = _repository.totalCount;
    final favorites = _repository.favoriteCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A56DB),
        foregroundColor: Colors.white,
        elevation: 2,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Danh bạ liên hệ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Sinh viên: Đỗ Quốc Khánh - B24DCCC157',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFD1E4FF),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. Khối thống kê: Tổng số & Yêu thích
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFE1EFFE),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFF1E429F),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Tổng số: $total   |   Yêu thích: $favorites',
                      style: const TextStyle(
                        color: Color(0xFF1E429F),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Danh sách liên hệ
          Expanded(
            child: contacts.isEmpty
                ? const Center(
                    child: Text(
                      'Chưa có liên hệ nào trong danh bạ',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 15,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ContactItem(
                        contact: contact,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ContactDetailScreen(
                                contactId: contact.id,
                              ),
                            ),
                          );
                          _refreshList();
                        },
                      );
                    },
                  ),
          ),

          // 3. Nút Thêm liên hệ
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddContactScreen(),
                      ),
                    );
                    _refreshList();
                  },
                  icon: const Icon(Icons.add_rounded, size: 22),
                  label: const Text(
                    'THÊM LIÊN HỆ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A56DB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
