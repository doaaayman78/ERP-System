import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../views/landing_side_bar_view.dart';

class LandingScreen extends StatelessWidget {
  final Widget contentArea;
  const LandingScreen({super.key, required this.contentArea});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            height: constraints.maxHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LandingSideBarView(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                    ),
                    child: contentArea,
                  ),
                ),
              ],
            ),
          ),
      )
    );
  }
}