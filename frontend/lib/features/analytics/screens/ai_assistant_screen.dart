import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared_ui/erp_page_header.dart';
import '../../../shared_ui/erp_section_card.dart';
import '../../../shared_ui/status_badge.dart';

// TODO [AI SERVICE]: Connect _send() to your AI Assistant / Analytics endpoint and render
// structured answers, recommendations, and links to underlying ERP records.
class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final _ctrl = TextEditingController();
  final List<String> _messages = [
    'Ask about sales, inventory, purchases, cash flow or product trends. Responses respect your role permissions.',
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add('You: $text');
      _messages.add('AURA AI (Mock): AI service is not connected yet. Once deployed, responses will use your authorized ERP data.');
    });
    _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ErpPageHeader(
            title: 'AURA AI Business Assistant',
            subtitle: 'Query your authorized ERP data in natural language.',
            trailing: StatusBadge(label: 'Mock Mode', tone: BadgeTone.info),
          ),
          const SizedBox(height: 20),
          ErpSectionCard(
            title: 'Ask your business data',
            child: Column(
              children: [
                Container(
                  height: 360,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.separated(
                    itemCount: _messages.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, idx) => Text(_messages[idx]),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        onSubmitted: (_) => _send(),
                        decoration: const InputDecoration(hintText: 'e.g. Which products are running low?'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: _send, child: const Text('Send')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
