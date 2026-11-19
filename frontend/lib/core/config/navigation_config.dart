import 'package:material_ui/material_ui.dart';

enum UserRole {
  admin('Administrator'),
  manager('Manager'),
  warehouseEmployee('Inventory Manager'),
  salesEmployee('Sales Employee'),
  purchasingEmployee('Purchasing Employee'),
  accountant('Accountant'),
  cashier('Cashier');

  final String displayName;
  const UserRole(this.displayName);
}

class SidebarNavItem {
  final String title;
  final String route;
  final IconData icon;
  final String section; // 'WORKSPACE' or 'ADMINISTRATION'
  final Set<UserRole> allowedRoles;

  const SidebarNavItem({
    required this.title,
    required this.route,
    required this.icon,
    required this.section,
    required this.allowedRoles,
  });
}

abstract final class NavigationConfig {
  static const allRoles = {
    UserRole.admin,
    UserRole.manager,
    UserRole.warehouseEmployee,
    UserRole.salesEmployee,
    UserRole.purchasingEmployee,
    UserRole.accountant,
    UserRole.cashier,
  };

  static const List<SidebarNavItem> items = [
    SidebarNavItem(
      title: 'Dashboard (Power BI)',
      route: '/analytics/dashboard',
      icon: Icons.dashboard_outlined,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.accountant},
    ),
    SidebarNavItem(
      title: 'Products & Catalog',
      route: '/products',
      icon: Icons.inventory_2_outlined,
      section: 'WORKSPACE',
      allowedRoles: {
        UserRole.admin,
        UserRole.manager,
        UserRole.warehouseEmployee,
        UserRole.salesEmployee,
        UserRole.purchasingEmployee,
      },
    ),
    SidebarNavItem(
      title: 'Inventory & Stock',
      route: '/inventory',
      icon: Icons.warehouse_outlined,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.warehouseEmployee},
    ),
    SidebarNavItem(
      title: 'Sales & Invoices',
      route: '/sales',
      icon: Icons.point_of_sale_outlined,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.salesEmployee, UserRole.cashier, UserRole.accountant},
    ),
    SidebarNavItem(
      title: 'Customers',
      route: '/customers',
      icon: Icons.people_outline,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.salesEmployee, UserRole.accountant},
    ),
    SidebarNavItem(
      title: 'Purchases',
      route: '/purchases',
      icon: Icons.shopping_cart_outlined,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.purchasingEmployee, UserRole.warehouseEmployee, UserRole.accountant},
    ),
    SidebarNavItem(
      title: 'Suppliers',
      route: '/suppliers',
      icon: Icons.local_shipping_outlined,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.purchasingEmployee, UserRole.accountant},
    ),
    SidebarNavItem(
      title: 'Returns',
      route: '/returns',
      icon: Icons.assignment_return_outlined,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.salesEmployee, UserRole.purchasingEmployee, UserRole.accountant},
    ),
    SidebarNavItem(
      title: 'Payments & Finance',
      route: '/finance',
      icon: Icons.account_balance_outlined,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.accountant},
    ),
    SidebarNavItem(
      title: 'OCR Scanner',
      route: '/analytics/ocr',
      icon: Icons.document_scanner_outlined,
      section: 'WORKSPACE',
      allowedRoles: {UserRole.admin, UserRole.manager, UserRole.warehouseEmployee, UserRole.purchasingEmployee},
    ),
    SidebarNavItem(
      title: 'AI Assistant',
      route: '/analytics/ai',
      icon: Icons.auto_awesome_outlined,
      section: 'WORKSPACE',
      allowedRoles: allRoles,
    ),
    SidebarNavItem(
      title: 'Users & Permissions',
      route: '/users',
      icon: Icons.admin_panel_settings_outlined,
      section: 'ADMINISTRATION',
      allowedRoles: {UserRole.admin},
    ),
  ];

  static List<SidebarNavItem> visibleForRole(UserRole role, {bool isEmployeeFlavor = false}) {
    return items.where((item) {
      if (isEmployeeFlavor && item.section == 'ADMINISTRATION') return false;
      if (role == UserRole.admin) return true;
      return item.allowedRoles.contains(role);
    }).toList();
  }

  static bool canAccess(UserRole role, String path, {bool isEmployeeFlavor = false}) {
    final visible = visibleForRole(role, isEmployeeFlavor: isEmployeeFlavor);
    return visible.any((item) => path.startsWith(item.route));
  }

  static String defaultRouteForRole(UserRole role, {bool isEmployeeFlavor = false}) {
    final visible = visibleForRole(role, isEmployeeFlavor: isEmployeeFlavor);
    return visible.isNotEmpty ? visible.first.route : '/login';
  }
}
