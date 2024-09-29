import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_manager/helpers/snackbar_helper.dart';
import 'package:order_manager/ui/components/app_dropdown.dart';
import 'package:order_manager/ui/pages/reports/report_binding.dart';
import 'package:order_manager/utils/dropdown_utils.dart';
import '../../../settings/app_colors.dart';
import '../../../utils/table_utils.dart';
import '../../components/app_buttom.dart';
import '../../components/app_chart.dart';
import '../../components/app_scaffold.dart';
import '../../components/app_table.dart';
import 'report_controller.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  late ReportController _controller;
  late Future _setupController;

  @override
  void initState(){
    _setupController = setupController();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  Future setupController() async {
    await setUpReport();
    _controller = Get.find<ReportController>();
    _controller.getReportsCharts();
  }

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      title: "Relatórios",
      body: FutureBuilder(
        future: _setupController,
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done
          ? LayoutBuilder(
            builder: (context, constrains) {
              return Column(
                children: [
                  SizedBox(
                    height: constrains.maxHeight/2 - 10,
                    child: Obx(() => Row(
                      children: [
                        ..._controller.reportCharts
                          .map((e) => Expanded(
                            child: AppChart(
                              title: e.title,
                              datas: e.data,
                              showLegends: true,
                              showDataLabel: e.showDataLabel,
                              chartType: e.type,
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),

                  const SizedBox(height: 20,),

                  SizedBox(
                    height: constrains.maxHeight/2 - 10,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppDropdown(
                              width: constrains.maxWidth - 110,
                              controller: AppDropdownController(
                                items: DropdownUtils.getReportsValues(),
                                onValueSelected: (value) => _controller.setDropdownSelected(value),
                              ),
                            ),

                            const SizedBox(width: 10,),

                            Obx(() => SizedBox(
                              width: 100,
                              child: AppButton(
                                onPressed: () => _controller.exportTable(),
                                label: "Exportar",
                                isLoading: _controller.isLoading.value,
                              ),
                            ))
                          ],
                        ),

                        const SizedBox(height: 10,),

                        Obx(() => _controller.dropdownSelected.value == null ? Container() : AppTable(
                          maxHeight: (constrains.maxHeight/2 - 70),
                          headers: TableUtils.reportTableColumns(_controller.dropdownSelected.value!.value),
                          source: _controller.reportTable
                            .map((e) => e.toMap(_controller.dropdownSelected.value!.value))
                            .toList(),
                        ))
                      ],
                    )
                  ),
                ],
              );
            }
        ) : const Center(child: CircularProgressIndicator(color: AppColors.blueDarkColor,),)
      ),
    );
  }
}