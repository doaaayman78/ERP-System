import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/status_badge.dart';
import '../cubit/sales_cubit.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesCubit, SalesState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ErpPageHeader(
                title: 'Customers',
                subtitle: 'Maintain wholesale and retail customer profiles, credit limits and balances.',
              ),
              const SizedBox(height: 20),
              ErpDataTableCard(
                title: 'Customer directory',
                onSearchChanged: context.read<SalesCubit>().setSearch,
                columns: const ['Code', 'Customer', 'Phone', 'Type', 'Credit Limit', 'Balance', 'Status'],
                rows: state.filteredCustomers
                    .map((c) => [
                          Text(c.id),
                          Text(c.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(c.phone),
                          StatusBadge(label: c.type, tone: BadgeTone.info),
                          Text(AppFormatters.currency(c.creditLimit)),
                          Text(AppFormatters.currency(c.balance)),
                          StatusBadge.fromStatus(c.status),
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
