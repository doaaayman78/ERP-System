import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/erp_section_card.dart';
import '../../../shared_ui/kpi_metric_card.dart';
import '../../../shared_ui/status_badge.dart';
import '../cubit/inventory_cubit.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        final totalUnits = state.stock.fold<int>(0, (sum, s) => sum + s.onHand);
        final lowCount = state.stock.where((s) => s.status != 'Healthy').length;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ErpPageHeader(
                title: 'Inventory & Warehouse',
                subtitle: 'Track stock levels, locations, movements, adjustments and expiry.',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: KpiMetricCard(label: 'Total stock units', value: '$totalUnits', caption: 'Across warehouses')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiMetricCard(label: 'Low / Out of stock', value: '$lowCount', caption: 'Reorder recommended', captionColor: AppColors.warning)),
                  const SizedBox(width: 16),
                  const Expanded(child: KpiMetricCard(label: 'Expiring soon', value: '1', caption: 'Within 30 days', captionColor: AppColors.error)),
                  const SizedBox(width: 16),
                  Expanded(child: KpiMetricCard(label: 'Stock movements', value: '${state.movements.length}', caption: 'Recent ledger events')),
                ],
              ),
              const SizedBox(height: 20),
              ErpDataTableCard(
                title: 'Stock by product & location',
                onSearchChanged: context.read<InventoryCubit>().setSearch,
                filterOptions: const ['All', 'Main warehouse', 'Store A', 'Store B'],
                selectedFilter: state.warehouseFilter,
                onFilterChanged: context.read<InventoryCubit>().setWarehouse,
                columns: const ['Product', 'Warehouse', 'On Hand', 'Reserved', 'Available', 'Status'],
                rows: state.filteredStock
                    .map((s) => [
                          Text(s.productName, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(s.warehouse),
                          Text('${s.onHand}'),
                          Text('${s.reserved}'),
                          Text('${s.available}'),
                          StatusBadge.fromStatus(s.status),
                        ])
                    .toList(),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ErpSectionCard(
                      title: 'Movement log / audit trail',
                      child: Column(
                        children: state.movements
                            .map((m) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text('${m.reference} — ${m.productName}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                  subtitle: Text(m.movementType, style: const TextStyle(fontSize: 12)),
                                  trailing: Text(
                                    m.delta > 0 ? '+${m.delta}' : '${m.delta}',
                                    style: TextStyle(fontWeight: FontWeight.w700, color: m.delta > 0 ? AppColors.success : AppColors.error),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ErpSectionCard(
                      title: 'Attention required',
                      child: Column(
                        children: state.stock
                            .where((s) => s.status != 'Healthy' || s.expiryWarning != null)
                            .map((s) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(s.productName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                  subtitle: Text(s.expiryWarning ?? '${s.available} units remaining', style: const TextStyle(fontSize: 12)),
                                  trailing: StatusBadge.fromStatus(s.status == 'Out of stock' ? 'Critical' : 'Review'),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
