// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:control_de_personal/main.dart';

void main() {
  testWidgets('Control de Personal app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ControlPersonalApp());

    // Verify that the app title is displayed
    expect(find.text('Control de Personal'), findsOneWidget);
    expect(find.text('Sistema de Gestión'), findsOneWidget);

    // Verify that all person buttons are displayed
    expect(find.text('DIONI'), findsOneWidget);
    expect(find.text('GERMAN'), findsOneWidget);
    expect(find.text('LUTE'), findsOneWidget);
    expect(find.text('VICTOR'), findsOneWidget);

    // Verify that the administration button is displayed
    expect(find.text('ADMINISTRACIÓN'), findsOneWidget);

    // Verify that the "Personal Disponible" title is displayed
    expect(find.text('Personal Disponible'), findsOneWidget);
  });

  testWidgets('Person buttons are tappable', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ControlPersonalApp());

    // Tap on DIONI button
    await tester.tap(find.text('DIONI'));
    await tester.pump();

    // Tap on GERMAN button
    await tester.tap(find.text('GERMAN'));
    await tester.pump();

    // Tap on LUTE button
    await tester.tap(find.text('LUTE'));
    await tester.pump();

    // Tap on VICTOR button
    await tester.tap(find.text('VICTOR'));
    await tester.pump();

    // Tap on ADMINISTRACIÓN button
    await tester.tap(find.text('ADMINISTRACIÓN'));
    await tester.pump();
  });
}
