import 'package:flutter/material.dart';
import 'package:order_manager/settings/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../data/models/components/chart_model.dart';
import '../../utils/chart_utils.dart';

enum ChartType { pie, bar }

class AppChart extends StatefulWidget {

  final String title;
  final List<ChartModel> datas;
  final bool showLegends;
  final ChartType chartType;
  final bool enableAnimation;
  final bool showDataLabel;
  final bool isHorizontal;

  const AppChart({
    super.key,
    required this.title,
    required this.datas,
    required this.chartType,
    this.showLegends = true,
    this.enableAnimation = true,
    this.showDataLabel = false,
    this.isHorizontal = false,
  });

  @override
  State<AppChart> createState() => _AppChartState();
}

class _AppChartState extends State<AppChart> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      child: Center(
        child: widget.chartType == ChartType.pie
          ? _buildPieChart()
          : _buildBarChart(),
      ),
    );
  }

  Widget _buildPieChart() {
    return SfCircularChart(
      title: ChartTitle(text: widget.title),
      legend: Legend(isVisible: widget.showLegends),
      series: <PieSeries<ChartModel, String>>[
        PieSeries<ChartModel, String>(
          dataSource: widget.datas,
          xValueMapper: (ChartModel data, _) => data.name,
          yValueMapper: (ChartModel data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: widget.showDataLabel),
          pointColorMapper: (ChartModel data, _) => ChartUtils.chartColors().elementAt(widget.datas.indexOf(data)),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return SfCartesianChart(
      title: ChartTitle(text: widget.title),
      primaryXAxis: widget.isHorizontal ? const NumericAxis() : const CategoryAxis(),
      primaryYAxis: widget.isHorizontal ? const CategoryAxis() : const NumericAxis(),
      legend: Legend(isVisible: widget.showLegends),
      series: widget.isHorizontal
          ? <CartesianSeries<ChartModel, num>>[
        BarSeries<ChartModel, num>(
          dataSource: widget.datas,
          xValueMapper: (ChartModel data, _) => data.value,
          yValueMapper: (ChartModel data, _) => data.name == "APROVADO" ? 1 : 0,
          dataLabelSettings: DataLabelSettings(isVisible: widget.showDataLabel),
          pointColorMapper: (ChartModel data, _) => ChartUtils.chartColors().elementAt(widget.datas.indexOf(data)),
        )
      ] : <CartesianSeries<ChartModel, String>>[
        ColumnSeries<ChartModel, String>(
          dataSource: widget.datas,
          xValueMapper: (ChartModel data, _) => data.name,
          yValueMapper: (ChartModel data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: widget.showDataLabel),
          pointColorMapper: (ChartModel data, _) => ChartUtils.chartColors().elementAt(widget.datas.indexOf(data)),
        )
      ],
    );
  }
}