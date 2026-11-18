import 'package:material_ui/material_ui.dart';
import 'core/theme/app_theme.dart';
import 'features/landing/screens/landing_screen.dart';

void main(){
  runApp(const ERPApp());
}

class ERPApp extends StatelessWidget{
  const ERPApp({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'ERP System (Dev)',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const LandingScreen(),
      );
    }
}