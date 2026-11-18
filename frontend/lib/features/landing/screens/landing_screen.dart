import 'package:material_ui/material_ui.dart';
import '../views/landing_side_bar_view.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
                //const Expanded(child: SizedBox()),
              ],
            ),
          ),
      )
    );
  }
}