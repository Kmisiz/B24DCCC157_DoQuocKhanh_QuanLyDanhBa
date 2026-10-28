import 'package:flutter_test/flutter_test.dart';
import 'package:b24dccc157_quan_ly_danh_ba/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ContactManagerApp());
    expect(find.text('QUẢN LÝ DANH BẠ'), findsOneWidget);
    expect(find.text('ĐĂNG NHẬP'), findsOneWidget);
  });
}
