import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:b24dccc157_quan_ly_danh_ba/screens/login_screen.dart';
import 'package:b24dccc157_quan_ly_danh_ba/screens/main_screen.dart';
import 'package:b24dccc157_quan_ly_danh_ba/screens/add_contact_screen.dart';
import 'package:b24dccc157_quan_ly_danh_ba/screens/contact_detail_screen.dart';

Future<void> saveScreenshot(WidgetTester tester, GlobalKey key, String filename) async {
  await tester.pump(const Duration(milliseconds: 300));
  final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 2.0);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final pngBytes = byteData!.buffer.asUint8List();
  final file = File('screenshots/$filename');
  await file.writeAsBytes(pngBytes);
  print('Saved screenshots/$filename (${pngBytes.length} bytes)');
}

Widget buildTestApp(Widget child, GlobalKey key) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1A56DB),
        primary: const Color(0xFF1A56DB),
        secondary: const Color(0xFF0E9F6E),
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    ),
    home: RepaintBoundary(
      key: key,
      child: child,
    ),
  );
}

void main() {
  testWidgets('Capture real screenshots from Flutter app', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 2.0;

    // 1. LoginScreen (Normal)
    final keyLogin = GlobalKey();
    await tester.pumpWidget(buildTestApp(const LoginScreen(), keyLogin));
    await saveScreenshot(tester, keyLogin, 'screenshot_login.png');

    // 2. LoginScreen (Error state)
    await tester.tap(find.text('ĐĂNG NHẬP'));
    await saveScreenshot(tester, keyLogin, 'screenshot_login_error.png');

    // 3. MainScreen
    final keyMain = GlobalKey();
    await tester.pumpWidget(buildTestApp(const MainScreen(), keyMain));
    await saveScreenshot(tester, keyMain, 'screenshot_main.png');

    // 4. AddContactScreen (Normal)
    final keyAdd = GlobalKey();
    await tester.pumpWidget(buildTestApp(const AddContactScreen(), keyAdd));
    await saveScreenshot(tester, keyAdd, 'screenshot_add_contact.png');

    // 5. AddContactScreen (Error state: tap Save with empty inputs)
    await tester.tap(find.text('LƯU LIÊN HỆ'));
    await saveScreenshot(tester, keyAdd, 'screenshot_add_error.png');

    // 6. ContactDetailScreen (Detail of Contact '1')
    final keyDetail = GlobalKey();
    await tester.pumpWidget(buildTestApp(const ContactDetailScreen(contactId: '1'), keyDetail));
    await saveScreenshot(tester, keyDetail, 'screenshot_detail.png');

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
