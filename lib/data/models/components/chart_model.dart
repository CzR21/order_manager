import 'package:order_manager/ui/components/app_chart.dart';

class ChartTypeModel {

  final String title;
  final ChartType type;
  final bool showDataLabel;
  final List<ChartModel> data;

  ChartTypeModel({
    required this.title,
    required this.type,
    required this.showDataLabel,
    required this.data
  });

}

class ChartModel {

  final String name;
  final num value;

  ChartModel({
    required this.name,
    required this.value
  });

}