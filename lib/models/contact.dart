class Contact {
  final String id;
  String name;
  String phone;
  String group; // 'Gia đình', 'Bạn bè', 'Công việc', 'Khác'
  String gender; // 'Nam', 'Nữ', 'Khác'
  bool isFavorite;
  String note;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.group,
    required this.gender,
    this.isFavorite = false,
    this.note = '',
  });

  /// Lấy chữ cái đầu của tên (từ cuối cùng trong họ tên) để làm Avatar hiển thị
  String get initialLetter {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    final lastPart = parts.last;
    return lastPart.isNotEmpty ? lastPart[0].toUpperCase() : '?';
  }

  Contact copyWith({
    String? id,
    String? name,
    String? phone,
    String? group,
    String? gender,
    bool? isFavorite,
    String? note,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      group: group ?? this.group,
      gender: gender ?? this.gender,
      isFavorite: isFavorite ?? this.isFavorite,
      note: note ?? this.note,
    );
  }
}
