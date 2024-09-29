import 'dart:io';
import 'package:excel/excel.dart';
import 'package:order_manager/helpers/format_helper.dart';
import 'package:path_provider/path_provider.dart';

class ExportHelper {

  static Future<String> exportReportToExcel(List<Map<String, dynamic>> reportList) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Relatório'];

    sheetObject.appendRow(reportList.first.keys.map((e) => TextCellValue(e)).toList());

    for (var row in reportList) {
      sheetObject.appendRow([
        TextCellValue(row['name']),
        TextCellValue('${row['quantity']}'),
        TextCellValue(row['total'] ?? ''),
        TextCellValue(row['format'] ?? ''),
      ]);
    }
    
    var directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}\\Relatório ${FormatHelper.formatTimeStamp(DateTime.now())}.xlsx';

    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    return filePath;
  }

}