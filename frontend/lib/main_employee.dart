import 'package:material_ui/material_ui.dart';
import 'core/config/service_locator.dart';
import 'erp_app.dart';

void main() {
  setupServiceLocator();
  runApp(const ERPApp(appTitle: 'AURA ERP — Staff Workspace'));
}
