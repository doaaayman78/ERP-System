import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/config/env_config.dart';
import '../../../core/config/navigation_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';
import '../widgets/sidebar_nav_tile.dart';

class LandingSideBarView extends StatelessWidget {
  const LandingSideBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final user = authState.currentUser;
        final role = user?.role ?? UserRole.admin;
        final items = NavigationConfig.visibleForRole(
          role,
          isEmployeeFlavor: EnvConfig.isEmployeeFlavor,
        );
        final workspaceItems = items.where((i) => i.section == 'WORKSPACE').toList();
        final adminItems = items.where((i) => i.section == 'ADMINISTRATION').toList();

        return Container(
          width: 248.w,
          color: AppColors.sidebarBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AURA ERP Brand Header
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'A',
                        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800, fontSize: 18.sp),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AURA', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 15.sp, letterSpacing: 0.6)),
                        Text('ERP MANAGEMENT', style: TextStyle(color: AppColors.sidebarForeground, fontSize: 10.sp, letterSpacing: 0.8)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 12.h),
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 6.h),
                      child: Text(
                        'WORKSPACE',
                        style: TextStyle(color: AppColors.sidebarForeground, fontSize: 10.sp, fontWeight: FontWeight.w600, letterSpacing: 1.0),
                      ),
                    ),
                    ...workspaceItems.map((item) => SidebarNavTile(
                          title: item.title,
                          icon: item.icon,
                          isSelected: currentPath.startsWith(item.route),
                          onTap: () => context.go(item.route),
                        )),
                    if (adminItems.isNotEmpty) ...[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 6.h),
                        child: Text(
                          'ADMINISTRATION',
                          style: TextStyle(color: AppColors.sidebarForeground, fontSize: 10.sp, fontWeight: FontWeight.w600, letterSpacing: 1.0),
                        ),
                      ),
                      ...adminItems.map((item) => SidebarNavTile(
                            title: item.title,
                            icon: item.icon,
                            isSelected: currentPath.startsWith(item.route),
                            onTap: () => context.go(item.route),
                          )),
                    ],
                  ],
                ),
              ),
              // Bottom User Card
              Container(
                margin: EdgeInsets.all(12.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        (user?.name.isNotEmpty ?? false) ? user!.name[0].toUpperCase() : 'A',
                        style: TextStyle(color: AppColors.white, fontSize: 13.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'AURA User',
                            style: TextStyle(color: AppColors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            role.displayName,
                            style: TextStyle(color: AppColors.sidebarForeground, fontSize: 11.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Sign out',
                      icon: Icon(Icons.logout, size: 16.sp, color: AppColors.sidebarForeground),
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                        context.go('/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
