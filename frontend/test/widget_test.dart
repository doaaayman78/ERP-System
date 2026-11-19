import 'package:erp_system/core/config/service_locator.dart';
import 'package:erp_system/erp_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  setUpAll(() {
    setupServiceLocator();
  });

  testWidgets('ERP web app renders shell and default dashboard smoke test', (WidgetTester tester) async {
    // Use a desktop web viewport so the fixed sidebar and top bar render without overflow
    tester.view.physicalSize = const Size(1440, 860);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Build the ERP app and settle initial mock repository futures
    await tester.pumpWidget(const ERPApp(appTitle: 'AURA ERP (Test)'));
    await tester.pumpAndSettle();

    // Verify the fixed sidebar and default Power BI dashboard route render
    expect(find.text('AURA'), findsOneWidget);
    expect(find.text('Executive Dashboard (Power BI)'), findsOneWidget);
  });
}