import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../../features/analytics/screens/ai_assistant_screen.dart';
import '../../features/analytics/screens/ocr_scanner_screen.dart';
import '../../features/analytics/screens/power_bi_dashboard_screen.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/users_and_permissions_screen.dart';
import '../../features/catalog/screens/products_and_catalog_screen.dart';
import '../../features/finance/screens/company_finance_screen.dart';
import '../../features/inventory/screens/inventory_screen.dart';
import '../../features/landing/screens/landing_screen.dart';
import '../../features/procurement/screens/purchases_screen.dart';
import '../../features/procurement/screens/suppliers_screen.dart';
import '../../features/returns/screens/returns_screen.dart';
import '../../features/sales/screens/customers_screen.dart';
import '../../features/sales/screens/sales_and_invoices_screen.dart';
import 'env_config.dart';
import 'navigation_config.dart';
import 'service_locator.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/analytics/dashboard',
    redirect: (context, state) {
      final path = state.uri.path;
      final authState = sl<AuthCubit>().state;
      final role = authState.currentUser?.role ?? (EnvConfig.isEmployeeFlavor ? UserRole.salesEmployee : UserRole.admin);

      if (path == '/' || path.isEmpty) {
        return NavigationConfig.defaultRouteForRole(role, isEmployeeFlavor: EnvConfig.isEmployeeFlavor);
      }
      if (path == '/login') return null;

      if (!NavigationConfig.canAccess(role, path, isEmployeeFlavor: EnvConfig.isEmployeeFlavor)) {
        return NavigationConfig.defaultRouteForRole(role, isEmployeeFlavor: EnvConfig.isEmployeeFlavor);
      }
      return null;
    },
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => LandingScreen(contentArea: child),
        routes: [
          GoRoute(path: '/analytics/dashboard', builder: (_, __) => const PowerBiDashboardScreen()),
          GoRoute(path: '/analytics/ocr', builder: (_, __) => const OcrScannerScreen()),
          GoRoute(path: '/analytics/ai', builder: (_, __) => const AiAssistantScreen()),
          GoRoute(path: '/products', builder: (_, __) => const ProductsAndCatalogScreen()),
          GoRoute(path: '/inventory', builder: (_, __) => const InventoryScreen()),
          GoRoute(path: '/sales', builder: (_, __) => const SalesAndInvoicesScreen()),
          GoRoute(path: '/customers', builder: (_, __) => const CustomersScreen()),
          GoRoute(path: '/purchases', builder: (_, __) => const PurchasesScreen()),
          GoRoute(path: '/suppliers', builder: (_, __) => const SuppliersScreen()),
          GoRoute(path: '/returns', builder: (_, __) => const ReturnsScreen()),
          GoRoute(path: '/finance', builder: (_, __) => const CompanyFinanceScreen()),
          GoRoute(path: '/users', builder: (_, __) => const UsersAndPermissionsScreen()),
        ],
      ),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    ],
  );
}
