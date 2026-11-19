import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared_ui/erp_data_table_card.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/erp_section_card.dart';
import '../../../shared_ui/kpi_metric_card.dart';
import '../../../shared_ui/status_badge.dart';
import '../cubit/catalog_cubit.dart';

class ProductsAndCatalogScreen extends StatefulWidget {
  const ProductsAndCatalogScreen({super.key});

  @override
  State<ProductsAndCatalogScreen> createState() => _ProductsAndCatalogScreenState();
}

class _ProductsAndCatalogScreenState extends State<ProductsAndCatalogScreen> {
  final _nameCtrl = TextEditingController();
  final _barcodeCtrl = TextEditingController();
  final _priceCtrl = TextEditingController(text: '100');
  String _category = 'Supplements';
  String _brand = 'HealthPlus';
  String _unit = 'Box';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _barcodeCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ErpPageHeader(
                title: 'Product & Catalog',
                subtitle: 'Maintain products, categories, brands, units and barcodes.',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: KpiMetricCard(label: 'Total products', value: '${state.products.length}', caption: 'Catalog items')),
                  const SizedBox(width: 16),
                  const Expanded(child: KpiMetricCard(label: 'Categories', value: '5', caption: 'Subcategories included')),
                  const SizedBox(width: 16),
                  const Expanded(child: KpiMetricCard(label: 'Brands', value: '5', caption: 'Registered brands')),
                  const SizedBox(width: 16),
                  const Expanded(child: KpiMetricCard(label: 'Barcode coverage', value: '100%', caption: 'Products with barcode', captionColor: AppColors.success)),
                ],
              ),
              const SizedBox(height: 20),
              ErpDataTableCard(
                title: 'Product catalog',
                onSearchChanged: context.read<CatalogCubit>().setSearch,
                filterOptions: const ['All', 'Supplements', 'Personal care', 'Medicines', 'Medical supplies', 'Devices'],
                selectedFilter: state.categoryFilter,
                onFilterChanged: context.read<CatalogCubit>().setCategory,
                columns: const ['Product', 'SKU / Barcode', 'Category', 'Unit', 'Selling Price', 'Status'],
                rows: state.filteredProducts
                    .map((p) => [
                          Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text('${p.sku} / ${p.barcode}'),
                          Text(p.category),
                          Text(p.unit),
                          Text(AppFormatters.currency(p.retailPrice)),
                          StatusBadge.fromStatus(p.status),
                        ])
                    .toList(),
              ),
              const SizedBox(height: 20),
              ErpSectionCard(
                title: 'Quick Add Product',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: 240,
                          child: TextField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(labelText: 'Product name', hintText: 'Enter product name'),
                          ),
                        ),
                        SizedBox(
                          width: 185,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            initialValue: _category,
                            decoration: const InputDecoration(labelText: 'Category'),
                            items: const ['Supplements', 'Personal care', 'Medicines', 'Medical supplies', 'Devices']
                                .map((c) => DropdownMenuItem<String>(value: c, child: Text(c, overflow: TextOverflow.ellipsis)))
                                .toList(),
                            onChanged: (v) => setState(() => _category = v ?? _category),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            initialValue: _unit,
                            decoration: const InputDecoration(labelText: 'Unit'),
                            items: const ['Piece', 'Box', 'Bottle', 'Tube', 'Pack', 'Carton']
                                .map((u) => DropdownMenuItem<String>(value: u, child: Text(u, overflow: TextOverflow.ellipsis)))
                                .toList(),
                            onChanged: (v) => setState(() => _unit = v ?? _unit),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: TextField(controller: _priceCtrl, decoration: const InputDecoration(labelText: 'Retail Price (EGP)')),
                        ),
                        SizedBox(
                          width: 180,
                          child: TextField(controller: _barcodeCtrl, decoration: const InputDecoration(labelText: 'Barcode (optional)')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_nameCtrl.text.trim().isEmpty) return;
                        context.read<CatalogCubit>().addProduct(
                              name: _nameCtrl.text.trim(),
                              category: _category,
                              brand: _brand,
                              unit: _unit,
                              barcode: _barcodeCtrl.text.trim(),
                              retailPrice: double.tryParse(_priceCtrl.text) ?? 0,
                            );
                        _nameCtrl.clear();
                        _barcodeCtrl.clear();
                      },
                      child: const Text('Save product'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
