import 'package:material_ui/material_ui.dart';
import '../core/theme/app_colors.dart';

enum BadgeTone { success, warning, error, info, neutral }

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeTone tone;

  const StatusBadge({super.key, required this.label, this.tone = BadgeTone.neutral});

  factory StatusBadge.fromStatus(String status) {
    final s = status.toLowerCase();
    if (s.contains('paid') || s.contains('active') || s.contains('healthy') || s.contains('confirmed') || s.contains('posted') || s.contains('configured') || s.contains('ready') || s.contains('connected')) {
      return StatusBadge(label: status, tone: BadgeTone.success);
    }
    if (s.contains('pending') || s.contains('low') || s.contains('partial') || s.contains('draft') || s.contains('invited') || s.contains('review') || s.contains('expir')) {
      return StatusBadge(label: status, tone: BadgeTone.warning);
    }
    if (s.contains('out of stock') || s.contains('critical') || s.contains('cancel') || s.contains('blocked') || s.contains('unpaid') || s.contains('damaged')) {
      return StatusBadge(label: status, tone: BadgeTone.error);
    }
    return StatusBadge(label: status, tone: BadgeTone.info);
  }

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      BadgeTone.success => (AppColors.successLight, AppColors.success),
      BadgeTone.warning => (AppColors.warningLight, AppColors.warning),
      BadgeTone.error => (AppColors.errorLight, AppColors.error),
      BadgeTone.info => (AppColors.infoLight, AppColors.info),
      BadgeTone.neutral => (AppColors.pageBackground, AppColors.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
