import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/kpi_metric_card.dart';
import '../../../shared_ui/status_badge.dart';

// TODO [BACKEND API / FINANCE]: Wire to FinanceCubit + FinanceRepository for live ledger & payments.
class CompanyFinanceScreen extends StatelessWidget {
  const CompanyFinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ErpPageHeader(
            title: 'Financial & Payment',
            subtitle: 'Record customer and supplier payments and review immutable ledger balances.',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: KpiMetricCard(label: 'Cash received', value: AppFormatters.currency(92400), caption: 'This month', captionColor: AppColors.success)),
              const SizedBox(width: 16),
              Expanded(child: KpiMetricCard(label: 'Receivables', value: AppFormatters.currency(32800), caption: 'Customer balances', captionColor: AppColors.warning)),
              const SizedBox(width: 16),
              Expanded(child: KpiMetricCard(label: 'Payables', value: AppFormatters.currency(74200), caption: 'Supplier balances', captionColor: AppColors.error)),
              const SizedBox(width: 16),
              Expanded(child: KpiMetricCard(label: 'Net position', value: AppFormatters.currency(18200), caption: 'Current period')),
            ],
          ),
          const SizedBox(height: 20),
          ErpDataTableCard(
            title: 'Payment transactions',
            columns: const ['Reference', 'Party', 'Type', 'Date', 'Amount', 'Method', 'Status'],
            rows: [
              [const Text('PAY-2081', style: TextStyle(fontWeight: FontWeight.w600)), const Text('Ahmed Hassan'), const Text('Customer'), const Text('16 Nov'), Text(AppFormatters.currency(2000)), const Text('Cash'), StatusBadge.fromStatus('Posted')],
              [const Text('PAY-2080', style: TextStyle(fontWeight: FontWeight.w600)), const Text('Nile Medical Co.'), const Text('Supplier'), const Text('16 Nov'), Text(AppFormatters.currency(5000)), const Text('Bank'), StatusBadge.fromStatus('Posted')],
              [const Text('PAY-2079', style: TextStyle(fontWeight: FontWeight.w600)), const Text('Mona Adel'), const Text('Customer'), const Text('15 Nov'), Text(AppFormatters.currency(850)), const Text('Cash'), StatusBadge.fromStatus('Pending')],
            ],
          ),
        ],
      ),
    );
  }
}
