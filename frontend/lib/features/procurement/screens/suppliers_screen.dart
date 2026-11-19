import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/status_badge.dart';
import '../cubit/procurement_cubit.dart';

class SuppliersScreen extends StatelessWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcurementCubit, ProcurementState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ErpPageHeader(
                title: 'Suppliers & Representatives',
                subtitle: 'Manage supplier profiles, company tags, credit limits and payables.',
              ),
              const SizedBox(height: 20),
              ErpDataTableCard(
                title: 'Supplier directory',
                onSearchChanged: context.read<ProcurementCubit>().setSearch,
                columns: const ['Supplier', 'Code', 'Contact', 'Credit Limit', 'Balance', 'Status'],
                rows: state.filteredSuppliers
                    .map((s) => [
                          Text(s.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(s.code),
                          Text(s.contact),
                          Text(AppFormatters.currency(s.creditLimit)),
                          Text(AppFormatters.currency(s.balance)),
                          StatusBadge.fromStatus(s.status),
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
