import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/kpi_metric_card.dart';
import '../../../shared_ui/status_badge.dart';
import '../cubit/sales_cubit.dart';

class SalesAndInvoicesScreen extends StatelessWidget {
  const SalesAndInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesCubit, SalesState>(
      builder: (context, state) {
        final totalSales = state.invoices.fold<double>(0, (sum, i) => sum + i.total);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ErpPageHeader(
                title: 'Sales & Invoices',
                subtitle: 'Manage sales invoices, wholesale/retail pricing and payment collection.',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: KpiMetricCard(label: 'Sales this month', value: AppFormatters.currency(totalSales), caption: '+8.2% vs last month', captionColor: AppColors.success)),
                  const SizedBox(width: 16),
                  Expanded(child: KpiMetricCard(label: 'Total invoices', value: '${state.invoices.length}', caption: 'Confirmed & Draft', captionColor: AppColors.warning)),
                  const SizedBox(width: 16),
                  Expanded(child: KpiMetricCard(label: 'Customers', value: '${state.customers.length}', caption: 'Wholesale and retail')),
                  const SizedBox(width: 16),
                  const Expanded(child: KpiMetricCard(label: 'Returns this month', value: '2', caption: 'Customer returns')),
                ],
              ),
              const SizedBox(height: 20),
              ErpDataTableCard(
                title: 'Sales invoices',
                onSearchChanged: context.read<SalesCubit>().setSearch,
                columns: const ['Invoice', 'Customer', 'Date', 'Total', 'Payment', 'Status'],
                rows: state.filteredInvoices
                    .map((i) => [
                          Text(i.invoiceNumber, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(i.customerName),
                          Text(i.date),
                          Text(AppFormatters.currency(i.total)),
                          StatusBadge.fromStatus(i.paymentStatus),
                          StatusBadge.fromStatus(i.status),
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
