import 'package:order_manager/helpers/format_helper.dart';

class ReportTableModel {

  final String name;
  final int quantity;
  final double total;
  final String? format;

  ReportTableModel({
    required this.name,
    required this.quantity,
    required this.total,
    this.format,
  });

  Map<String, dynamic> toMap(int index) {
    return {
      'name': name,
      index == 1 ? 'format' : 'quantity': index == 1 ? format ?? "" : quantity,
      'total': FormatHelper.formatCurrency(total),
    };
  }
}