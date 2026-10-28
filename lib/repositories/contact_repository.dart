import '../models/contact.dart';

/// Kho dữ liệu In-Memory (Singleton) quản lý danh bạ liên hệ
class ContactRepository {
  static final ContactRepository _instance = ContactRepository._internal();
  factory ContactRepository() => _instance;

  ContactRepository._internal() {
    _initSampleData();
  }

  final List<Contact> _contacts = [];

  void _initSampleData() {
    _contacts.addAll([
      Contact(
        id: '1',
        name: 'Nguyễn Văn An',
        phone: '0901234567',
        group: 'Bạn bè',
        gender: 'Nam',
        isFavorite: false,
        note: 'Bạn thời đại học',
      ),
      Contact(
        id: '2',
        name: 'Trần Thị Bình',
        phone: '0912345678',
        group: 'Gia đình',
        gender: 'Nữ',
        isFavorite: true,
        note: 'Chị gái ruột',
      ),
      Contact(
        id: '3',
        name: 'Lê Minh Châu',
        phone: '0987654321',
        group: 'Công việc',
        gender: 'Khác',
        isFavorite: false,
        note: 'Đồng nghiệp cùng phòng',
      ),
    ]);
  }

  List<Contact> get contacts => List.unmodifiable(_contacts);

  int get totalCount => _contacts.length;

  int get favoriteCount => _contacts.where((c) => c.isFavorite).length;

  void addContact(Contact contact) {
    _contacts.add(contact);
  }

  void removeContact(String id) {
    _contacts.removeWhere((c) => c.id == id);
  }

  void updateContact(Contact updated) {
    final index = _contacts.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      _contacts[index] = updated;
    }
  }

  void toggleFavorite(String id) {
    final index = _contacts.indexWhere((c) => c.id == id);
    if (index != -1) {
      _contacts[index].isFavorite = !_contacts[index].isFavorite;
    }
  }

  Contact? getById(String id) {
    try {
      return _contacts.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  bool isPhoneExists(String phone, {String? excludeId}) {
    final cleanPhone = phone.trim();
    return _contacts.any(
      (c) => c.phone.trim() == cleanPhone && (excludeId == null || c.id != excludeId),
    );
  }
}
