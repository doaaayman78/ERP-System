import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/erp_section_card.dart';
import '../../../shared_ui/status_badge.dart';

// TODO [AI / OCR SERVICE]: Connect file picker / upload to OCR endpoint and display extracted fields
// for user review and confirmation before creating a purchase transaction.
class OcrScannerScreen extends StatelessWidget {
  const OcrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ErpPageHeader(
            title: 'OCR Invoice Scanner',
            subtitle: 'Upload supplier invoices, review extracted line items and confirm before saving.',
            trailing: StatusBadge(label: 'AI Service Pending', tone: BadgeTone.info),
          ),
          const SizedBox(height: 20),
          ErpSectionCard(
            title: 'Extract invoice data',
            child: Column(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 44, color: AppColors.primary),
                      SizedBox(height: 10),
                      Text('Drop supplier invoice PDF or image here', style: AppTextStyles.title),
                      SizedBox(height: 4),
                      Text('PDF, JPG or PNG — extracted fields will require confirmation before saving.', style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO [AI / OCR SERVICE]: Trigger invoice upload & extraction request
                      },
                      icon: const Icon(Icons.upload_file, size: 18),
                      label: const Text('Upload invoice'),
                    ),
                    const Spacer(),
                    const StatusBadge(label: 'Ready', tone: BadgeTone.success),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
