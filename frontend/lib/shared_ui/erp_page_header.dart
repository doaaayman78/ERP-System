import 'package:material_ui/material_ui.dart';
import '../core/theme/app_text_styles.dart';

class ErpPageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;

  const ErpPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.headline1),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
