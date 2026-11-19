import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../views/landing_side_bar_view.dart';
import '../views/landing_top_bar_view.dart';

class LandingScreen extends StatelessWidget {
  final Widget contentArea;

  const LandingScreen({super.key, required this.contentArea});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LandingSideBarView(),
          Expanded(
            child: Column(
              children: [
                const LandingTopBarView(),
                Expanded(
                  child: Container(
                    color: AppColors.pageBackground,
                    child: contentArea,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
