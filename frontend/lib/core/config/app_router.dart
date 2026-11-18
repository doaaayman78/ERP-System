import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

// Feature screen imports
import '../../features/landing/screens/landing_screen.dart';
import '../../features/catalog/screens/products_and_catalog_screen.dart';
import '../../features/sales/screens/sales_and_invoices_screen.dart';
import '../../features/sales/screens/customers_screen.dart';
import '../../features/procurement/screens/purchases_screen.dart';
import '../../features/procurement/screens/suppliers_screen.dart';
import '../../features/finance/screens/company_finance_screen.dart';
// Add remaining imports...

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/landing',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
          // The 'child' is the screen mapped to the current URL
        builder: (context, state, child) => LandingScreen(contentArea: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const Center(child: Text('Dashboard View')),
          ),
          GoRoute(
            path: '/products',
            builder: (context, state) => const ProductsAndCatalogScreen(),
          ),
          GoRoute(
            path: '/sales',
            builder: (context, state) => const SalesAndInvoicesScreen(),
          ),
          GoRoute(
            path: '/purchases',
            builder: (context, state) => const PurchasesScreen(),
          ),
          GoRoute(
            path: '/customers',
            builder: (context, state) => const CustomersScreen(),
          ),
          GoRoute(
            path: '/suppliers',
            builder: (context, state) => const SuppliersScreen(),
          ),
          GoRoute(
            path: '/finance',
            builder: (context, state) => const CompanyFinanceScreen(),
          ),
          // Add remaining routes (OCR Scanner, AI Assistant, etc.)
        ]
      ),

      // Routes outside the ShellRoute take up the entire screen (no sidebar)
      GoRoute(
        path: '/login',
        builder: (context, state) => const Center(child: Text('Login Screen')),
      ),
    ]
  );
}