abstract final class AppFormatters {
  static String currency(double amount, {String symbol = 'EGP'}) {
    final formatted = amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2);
    final parts = formatted.split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return parts.length > 1 ? '$symbol $intPart.${parts[1]}' : '$symbol $intPart';
  }
}
