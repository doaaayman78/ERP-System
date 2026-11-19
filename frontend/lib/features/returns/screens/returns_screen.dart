import 'package:material_ui/material_ui.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/status_badge.dart';

// TODO [BACKEND API / RETURNS]: Wire to ReturnsCubit + ReturnsRepository once backend endpoint is ready.
class ReturnsScreen extends StatelessWidget {
  const ReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ErpPageHeader(
            title: 'Returns & Settlements',
            subtitle: 'Process customer and supplier returns, damaged stock and refunds.',
          ),
          const SizedBox(height: 20),
          ErpDataTableCard(
            title: 'Return transactions',
            columns: const ['Return ID', 'Type', 'Party', 'Destination', 'Refund Amount', 'Status'],
            rows: [
              [
                const Text('RET-2026-019', style: TextStyle(fontWeight: FontWeight.w600)),
                const StatusBadge(label: 'Customer', tone: BadgeTone.info),
                const Text('Ahmed Hassan'),
                const Text('Back to Stock'),
                Text(AppFormatters.currency(450)),
                StatusBadge.fromStatus('Confirmed'),
              ],
              [
                const Text('RET-2026-018', style: TextStyle(fontWeight: FontWeight.w600)),
                const StatusBadge(label: 'Supplier', tone: BadgeTone.warning),
                const Text('Nile Medical Co.'),
                const Text('Damaged Stock'),
                Text(AppFormatters.currency(1200)),
                StatusBadge.fromStatus('Pending'),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
