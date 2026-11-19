import 'package:material_ui/material_ui.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class KpiMetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String caption;
  final Color captionColor;
  final IconData? icon;
  final Color? iconBg;
  final Color? iconColor;

  const KpiMetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.caption,
    this.captionColor = AppColors.primary,
    this.icon,
    this.iconBg,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: iconBg ?? AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, size: 18, color: iconColor ?? AppColors.primary),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(label, style: AppTextStyles.bodySmall, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(value, style: AppTextStyles.metricValue),
            const SizedBox(height: 6),
            Text(
              caption,
              style: AppTextStyles.bodySmall.copyWith(color: captionColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
