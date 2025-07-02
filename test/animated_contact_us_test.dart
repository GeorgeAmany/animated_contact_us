import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:animated_contact_us/animated_contact_us.dart';

void main() {
  testWidgets('ContactUsWidget renders phone only', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AnimatedContactUs(phone: '+20123456789'),
        ),
      ),
    );

    expect(find.text('+20123456789'), findsOneWidget);
    expect(find.byType(AnimatedContactUs), findsOneWidget);
  });
}