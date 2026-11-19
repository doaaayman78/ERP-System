import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/kpi_metric_card.dart';
import '../../../shared_ui/status_badge.dart';
import '../cubit/procurement_cubit.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcurementCubit, ProcurementState>(
      builder: (context, state) {
        final payables = state.suppliers.fold<double>(0, (s, e) => s + e.balance);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ErpPageHeader(
                title: 'Purchases',
                subtitle: 'Manage purchase invoices, discounts, bonus quantities and receiving.',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: KpiMetricCard(label: 'Registered suppliers', value: '${state.suppliers.length}', caption: 'Approved suppliers')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiMetricCard(label: 'Purchase invoices', value: '${state.purchases.length}', caption: 'Recent orders')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiMetricCard(label: 'Supplier payables', value: AppFormatters.currency(payables), caption: 'Outstanding balance', captionColor: AppColors.warning)),
                  const SizedBox(width: 16),
                  const Expanded(child: KpiMetricCard(label: 'Returns this month', value: '1', caption: 'Supplier returns')),
                ],
              ),
              const SizedBox(height: 20),
              ErpDataTableCard(
                title: 'Purchase invoices',
                onSearchChanged: context.read<ProcurementCubit>().setSearch,
                columns: const ['Invoice', 'Supplier', 'Date', 'Bonus Units', 'Total', 'Status'],
                rows: state.filteredPurchases
                    .map((p) => [
                          Text(p.invoiceNumber, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(p.supplierName),
                          Text(p.date),
                          Text('+${p.bonusUnits} free'),
                          Text(AppFormatters.currency(p.total)),
                          StatusBadge.fromStatus(p.status),
                        ])
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
