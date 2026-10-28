import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;

  const ContactItem({
    super.key,
    required this.contact,
    required this.onTap,
  });

  Color _getAvatarColor(String letter) {
    const colors = [
      Color(0xFF3F83F8),
      Color(0xFF0E9F6E),
      Color(0xFF9061F9),
      Color(0xFFE02424),
      Color(0xFFFF5A1F),
      Color(0xFF0694A2),
    ];
    if (letter.isEmpty) return colors[0];
    final code = letter.codeUnitAt(0);
    return colors[code % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final avatarBg = _getAvatarColor(contact.initialLetter);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // 1. Avatar hình tròn chứa chữ cái đầu
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: avatarBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  contact.initialLetter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // 2. Họ tên, SĐT, Nhóm
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          contact.phone,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1EFFE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            contact.group,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E429F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 3. Dấu sao yêu thích
              Icon(
                contact.isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                color: contact.isFavorite ? const Color(0xFFF59E0B) : const Color(0xFFCBD5E1),
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
