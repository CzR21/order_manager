import 'package:get/get.dart';
import 'package:order_manager/data/models/components/chart_model.dart';
import 'package:order_manager/data/models/reports/report_table_model.dart';
import 'package:order_manager/helpers/export_helper.dart';
import 'package:order_manager/settings/app_routes.dart';
import 'package:order_manager/ui/components/app_dropdown.dart';
import '../../../data/models/components/dropdown_model.dart';
import '../../../data/models/components/snackbar_model.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../../services/reports/report_service.dart';

class ReportController extends GetxController{

  final ReportService reportService;

  final RxList<ChartTypeModel> _reportCharts = <ChartTypeModel>[].obs;
  RxList<ChartTypeModel> get reportCharts => _reportCharts;

  final RxList<ReportTableModel> _reportTable = <ReportTableModel>[].obs;
  RxList<ReportTableModel> get reportTable => _reportTable;

  final Rx<DropdownModel?> _dropdownSelected = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> get dropdownSelected => _dropdownSelected;

  final Rx<SnackBarModel?> _snackBarModel = Rx<SnackBarModel?>(null);
  SnackBarModel? get snackBarModel => _snackBarModel.value;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  ReportController({
    required this.reportService
  }){
    ever(_snackBarModel, (callback) {
      if (callback != null) {
        SnackBarHelper.show(
          context: AppRoutes.navigatorKey.currentContext!,
          snackBarType: _snackBarModel.value!.snackBarType,
          message: callback.message,
        );
      }
    });
  }

  Future getReportsCharts() async{
    try {
      _reportCharts.value = await reportService.getReportsCharts();
    } catch (ex) {
      _snackBarModel.value = SnackBarModel(
        message: "Erro ao buscar gráficos",
        snackBarType: SnackBarType.error,
      );
    }
  }

  Future getReportsTable() async {
    try{
      if(_dropdownSelected.value != null) _reportTable.value = await reportService.getReportTable(_dropdownSelected.value!.value);
    } catch (ex){
      _snackBarModel.value = SnackBarModel(
        message: "Erro ao buscar dados",
        snackBarType: SnackBarType.error,
      );
    }
  }

  Future exportTable() async {
    try{
      if(_dropdownSelected.value == null) return;

      _isLoading.value = true;

      String filePath = await ExportHelper.exportReportToExcel(_reportTable.map((e) => e.toMap(_dropdownSelected.value!.value)).toList());

      _snackBarModel.value = SnackBarModel(
        message: "Relatório \"$filePath\" exportado com sucesso",
        snackBarType: SnackBarType.success,
      );
    } catch (ex) {
      _snackBarModel.value = SnackBarModel(
        message: "Erro ao exportar relatório",
        snackBarType: SnackBarType.error,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  setDropdownSelected(DropdownModel? dropdownModel){
    _dropdownSelected.value = dropdownModel;
    getReportsTable();
  }
}