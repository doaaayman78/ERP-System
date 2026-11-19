import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/config/navigation_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/erp_section_card.dart';
import '../../../shared_ui/kpi_metric_card.dart';
import '../../../shared_ui/status_badge.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class UsersAndPermissionsScreen extends StatelessWidget {
  const UsersAndPermissionsScreen({super.key});

  void _showAddUserDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    UserRole selectedRole = UserRole.salesEmployee;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New User'),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Full Name')),
              const SizedBox(height: 12),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Corporate Email')),
              const SizedBox(height: 12),
              DropdownButtonFormField<UserRole>(
                isExpanded: true,
                initialValue: selectedRole,
                decoration: const InputDecoration(labelText: 'Role'),
                items: UserRole.values
                    .map((r) => DropdownMenuItem<UserRole>(
                          value: r,
                          child: Text(r.displayName, overflow: TextOverflow.ellipsis),
                        ))
                    .toList(),
                onChanged: (v) => selectedRole = v ?? UserRole.salesEmployee,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.trim().isNotEmpty && emailCtrl.text.trim().isNotEmpty) {
                context.read<AuthCubit>().addUser(nameCtrl.text.trim(), emailCtrl.text.trim(), selectedRole);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Create User'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final users = state.filteredUsers;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ErpPageHeader(
                title: 'Identity & Access Management',
                subtitle: 'Manage users, authentication, roles and permissions.',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: KpiMetricCard(
                      label: 'Active users',
                      value: '${state.users.length}',
                      caption: 'Across departments',
                      captionColor: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: KpiMetricCard(
                      label: 'Roles configured',
                      value: '${UserRole.values.length}',
                      caption: 'Role-based access',
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: KpiMetricCard(
                      label: 'Pending invitations',
                      value: '1',
                      caption: 'Awaiting activation',
                      captionColor: AppColors.warning,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: KpiMetricCard(
                      label: 'Security events',
                      value: '0',
                      caption: 'All systems normal',
                      captionColor: AppColors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ErpDataTableCard(
                title: 'Users & permissions',
                onSearchChanged: context.read<AuthCubit>().setSearch,
                filterOptions: ['All', ...UserRole.values.map((r) => r.displayName)],
                selectedFilter: state.roleFilter,
                onFilterChanged: context.read<AuthCubit>().setRoleFilter,
                primaryActionLabel: 'Add user',
                onPrimaryAction: () => _showAddUserDialog(context),
                columns: const ['User', 'Email', 'Role', 'Last Active', 'Status'],
                rows: users
                    .map((u) => [
                          Text(u.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(u.email),
                          Text(u.role.displayName),
                          Text(u.lastActive),
                          StatusBadge.fromStatus(u.status),
                        ])
                    .toList(),
              ),
              const SizedBox(height: 20),
              ErpSectionCard(
                title: 'Role-based access control',
                child: Column(
                  children: UserRole.values.map((r) {
                    final moduleCount = NavigationConfig.visibleForRole(r).length;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(r.displayName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: Text('$moduleCount authorized modules', style: const TextStyle(fontSize: 12)),
                      trailing: const StatusBadge(label: 'Configured', tone: BadgeTone.success),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
