import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

import 'core/theme/app_theme.dart';
import 'core/config/app_router.dart';

void main(){
  runApp(const ERPApp());
}

class ERPApp extends StatelessWidget{
  const ERPApp({super.key});

  @override
    Widget build(BuildContext context) {
      return ScreenUtilInit(
        designSize: const Size(1440, 860),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp.router(
          title: 'ERP System (Dev)',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.router,
        ),
      );

    }
}