import 'package:intl/intl.dart';

class FormatHelper {

  static String formatDate(DateTime date) => DateFormat('dd/MM/yyyy', 'pt_BR').format(date);

  static String formatTimeStamp(DateTime date) => DateFormat('yyyy-MM-dd_HH-mm-ss').format(date);

  static String formatFullDate(DateTime date) => DateFormat('EEEE, d \'de\' MMMM \'de\' y', 'pt_BR').format(date);

  static String formatCurrency(double value) => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);

  static String formatZipCode(String code) => '${code.substring(0, 5)}-${code.substring(5, 8)}';

  static String formatCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpf.length < 11) return cpf;

    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  }

  static String formatCNPJ(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    if (cnpj.length < 14) return cnpj;

    return '${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12)}';
  }

}