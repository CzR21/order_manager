import 'package:get/get.dart';
import '../../../services/reports/report_service.dart';
import '../../../settings/app_database.dart';
import 'report_controller.dart';

Future setUpReport() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  Get.put<ReportController>(
    ReportController(
      reportService: ReportService(
        orderDao: database.orderDao
      ),
    )
  );
}