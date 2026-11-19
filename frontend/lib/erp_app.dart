import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'core/config/app_router.dart';
import 'core/config/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/catalog/cubit/catalog_cubit.dart';
import 'features/inventory/cubit/inventory_cubit.dart';
import 'features/procurement/cubit/procurement_cubit.dart';
import 'features/sales/cubit/sales_cubit.dart';

class ERPApp extends StatelessWidget {
  final String appTitle;

  const ERPApp({super.key, required this.appTitle});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<CatalogCubit>()),
        BlocProvider(create: (_) => sl<InventoryCubit>()),
        BlocProvider(create: (_) => sl<SalesCubit>()),
        BlocProvider(create: (_) => sl<ProcurementCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(1440, 860),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: appTitle,
            theme: AppTheme.light,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
