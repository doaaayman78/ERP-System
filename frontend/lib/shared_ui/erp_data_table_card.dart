import 'package:material_ui/material_ui.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class ErpDataTableCard extends StatelessWidget {
  final String title;
  final String searchHint;
  final ValueChanged<String>? onSearchChanged;
  final List<String>? filterOptions;
  final String? selectedFilter;
  final ValueChanged<String?>? onFilterChanged;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final List<String> columns;
  final List<List<Widget>> rows;

  const ErpDataTableCard({
    super.key,
    required this.title,
    this.searchHint = 'Name, ID or code',
    this.onSearchChanged,
    this.filterOptions,
    this.selectedFilter,
    this.onFilterChanged,
    this.primaryActionLabel,
    this.onPrimaryAction,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.title),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (onSearchChanged != null)
                  SizedBox(
                    width: 260,
                    child: TextField(
                      onChanged: onSearchChanged,
                      decoration: InputDecoration(
                        hintText: searchHint,
                        prefixIcon: const Icon(Icons.search, size: 18),
                      ),
                    ),
                  ),
                if (filterOptions != null && onFilterChanged != null)
                  SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: selectedFilter ?? filterOptions!.first,
                      items: filterOptions!
                          .map(
                            (opt) => DropdownMenuItem<String>(
                              value: opt,
                              child: Text(opt, overflow: TextOverflow.ellipsis, maxLines: 1),
                            ),
                          )
                          .toList(),
                      onChanged: onFilterChanged,
                    ),
                  ),
                if (primaryActionLabel != null && onPrimaryAction != null)
                  ElevatedButton.icon(
                    onPressed: onPrimaryAction,
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(primaryActionLabel!, softWrap: false),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (rows.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text('No records found.', style: AppTextStyles.bodySmall),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 780),
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(AppColors.pageBackground),
                      columns: columns
                          .map((c) => DataColumn(label: Text(c.toUpperCase(), style: AppTextStyles.tableHeader)))
                          .toList(),
                      rows: rows
                          .map((cells) => DataRow(cells: cells.map((w) => DataCell(w)).toList()))
                          .toList(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
