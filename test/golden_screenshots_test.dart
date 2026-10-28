import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:b24dccc157_quan_ly_danh_ba/screens/login_screen.dart';
import 'package:b24dccc157_quan_ly_danh_ba/screens/main_screen.dart';
import 'package:b24dccc157_quan_ly_danh_ba/screens/add_contact_screen.dart';
import 'package:b24dccc157_quan_ly_danh_ba/screens/contact_detail_screen.dart';

Widget buildFrame(Widget child) {
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
    home: child,
  );
}

void main() {
  testWidgets('Golden 1 - Login Screen', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildFrame(const LoginScreen()));
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('../screenshots/screenshot_login.png'));
  });

  testWidgets('Golden 2 - Login Error State', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildFrame(const LoginScreen()));
    await tester.tap(find.text('ĐĂNG NHẬP'));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('../screenshots/screenshot_login_error.png'));
  });

  testWidgets('Golden 3 - Main Screen', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildFrame(const MainScreen()));
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('../screenshots/screenshot_main.png'));
  });

  testWidgets('Golden 4 - Add Contact Screen', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildFrame(const AddContactScreen()));
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('../screenshots/screenshot_add_contact.png'));
  });

  testWidgets('Golden 5 - Add Contact Error State', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildFrame(const AddContactScreen()));
    await tester.tap(find.text('LƯU LIÊN HỆ'));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('../screenshots/screenshot_add_error.png'));
  });

  testWidgets('Golden 6 - Contact Detail Screen', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildFrame(const ContactDetailScreen(contactId: '1')));
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('../screenshots/screenshot_detail.png'));
  });
}
