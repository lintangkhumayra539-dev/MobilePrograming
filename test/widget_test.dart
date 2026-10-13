import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_control_flow/main.dart';

void main() {
  testWidgets('app shows the selected day outfit', (WidgetTester tester) async {
    await tester.pumpWidget(const TugasControlFlowApp());

    expect(find.text('Control Flow Web'), findsOneWidget);
    expect(find.text('Pilih hari'), findsOneWidget);
    expect(find.text('Hari Senin: Pakai seragam merah putih'), findsOneWidget);
  });
}
