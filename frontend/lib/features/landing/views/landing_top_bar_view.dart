import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/config/env_config.dart';
import '../../../core/config/navigation_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';

class LandingTopBarView extends StatelessWidget {
  const LandingTopBarView({super.key});

  String _pageTitleForPath(String path) {
    for (final item in NavigationConfig.items) {
      if (path.startsWith(item.route)) return item.title;
    }
    return 'AURA ERP Workspace';
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return Container(
      constraints: BoxConstraints(minHeight: 64.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Text(
              _pageTitleForPath(currentPath),
              style: AppTextStyles.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            flex: 3,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280.w, minWidth: 140),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search this workspace...',
                  prefixIcon: Icon(Icons.search, size: 18.sp),
                  fillColor: AppColors.pageBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          if (EnvConfig.isDevFlavor)
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final currentRole = state.currentUser?.role ?? UserRole.admin;
                return SizedBox(
                  width: 235.w,
                  child: DropdownButtonFormField<UserRole>(
                    isExpanded: true,
                    initialValue: currentRole,
                    decoration: InputDecoration(
                      labelText: 'Dev Role Preview',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    ),
                    items: UserRole.values
                        .map(
                          (r) => DropdownMenuItem<UserRole>(
                            value: r,
                            child: Text(
                              r.displayName,
                              style: TextStyle(fontSize: 12.sp),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (role) {
                      if (role == null) return;
                      context.read<AuthCubit>().switchRoleForTesting(role);
                      if (!NavigationConfig.canAccess(role, currentPath)) {
                        context.go(NavigationConfig.defaultRouteForRole(role));
                      }
                    },
                  ),
                );
              },
            ),
          SizedBox(width: 12.w),
          OutlinedButton.icon(
            onPressed: () => context.go('/analytics/ai'),
            icon: Icon(Icons.auto_awesome, size: 16.sp),
            label: const Text('AI Assistant', softWrap: false, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
