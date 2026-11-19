import 'package:material_ui/material_ui.dart';
import '../../../core/config/env_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/erp_section_card.dart';
import '../../../shared_ui/status_badge.dart';

/// Dedicated screen for embedding the Power BI dashboard once published.
/// TODO [POWER BI]: When ready, register an HtmlElementView using dart:ui_web and web.HTMLIFrameElement
/// pointing to EnvConfig.powerBiEmbedUrl (or a token fetched from your backend/Power BI service).
class PowerBiDashboardScreen extends StatelessWidget {
  const PowerBiDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hasEmbedUrl = EnvConfig.powerBiEmbedUrl.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ErpPageHeader(
            title: 'Executive Dashboard (Power BI)',
            subtitle: 'Live business intelligence, sales trends, stock movement and financial KPIs.',
            trailing: StatusBadge(
              label: hasEmbedUrl ? 'Embed URL Configured' : 'Awaiting Power BI Dashboard',
              tone: hasEmbedUrl ? BadgeTone.success : BadgeTone.warning,
            ),
          ),
          const SizedBox(height: 20),
          ErpSectionCard(
            title: 'Power BI Report Container',
            subtitle: hasEmbedUrl
                ? 'Configured URL: ${EnvConfig.powerBiEmbedUrl}'
                : 'Pass --dart-define=POWER_BI_EMBED_URL=... once your Power BI dashboard is ready.',
            child: Container(
              height: 520,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.pageBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_rounded, size: 56, color: AppColors.primary),
                  SizedBox(height: 12),
                  Text('AURA ERP — Power BI Dashboard Slot', style: AppTextStyles.title),
                  SizedBox(height: 6),
                  Text(
                    'Power BI dashboard is not developed yet; mount the embedded report here when ready.',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
