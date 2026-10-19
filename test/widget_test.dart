import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_control_flow/main.dart';

void main() {
  testWidgets('user can register, log in, and see the app page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TugasControlFlowApp());

    expect(find.text('SEVIMA'), findsOneWidget);
    expect(find.byKey(const Key('sevimaLogo')), findsOneWidget);
    expect(find.text('Selamat Datang'), findsOneWidget);
    expect(find.text('Belum punya akun? Daftar'), findsOneWidget);

    await tester.tap(find.byKey(const Key('toggleAuthModeButton')));
    await tester.pumpAndSettle();
    expect(find.text('Buat Akun'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('usernameField')), 'demo');
    await tester.enterText(find.byKey(const Key('passwordField')), 'rahasia');
    await tester.enterText(
      find.byKey(const Key('confirmPasswordField')),
      'rahasia',
    );
    await tester.tap(find.byKey(const Key('submitButton')));
    await tester.pumpAndSettle();

    expect(find.text('Akun berhasil dibuat. Silakan masuk.'), findsOneWidget);
    expect(find.text('Selamat Datang'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('passwordField')), 'rahasia');
    await tester.tap(find.byKey(const Key('submitButton')));
    await tester.pumpAndSettle();

    expect(find.text('Control Flow Web'), findsOneWidget);
    expect(find.text('Halo, demo!'), findsOneWidget);
    expect(find.text('Pilih hari'), findsOneWidget);
    expect(find.text('Hari Senin: Pakai seragam merah putih'), findsOneWidget);

    await tester.tap(find.byTooltip('Keluar'));
    await tester.pumpAndSettle();
    expect(find.text('Selamat Datang'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('usernameField')), 'demo');
    await tester.enterText(find.byKey(const Key('passwordField')), 'rahasia');
    await tester.tap(find.byKey(const Key('submitButton')));
    await tester.pumpAndSettle();
    expect(find.text('Halo, demo!'), findsOneWidget);
  });
}
