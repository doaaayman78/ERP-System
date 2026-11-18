import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class LandingSideBarView extends StatelessWidget {
  const LandingSideBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 232.w,
      decoration: BoxDecoration(color: AppColors.sidebarBackground),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image(
            // -> Need to select the logo
            image: const AssetImage('assets/images/aura_logo.png'),
            height: 232.w,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

        ],
      ),
    );
  }
}
