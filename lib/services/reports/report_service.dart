import 'package:order_manager/data/entities/orders/address_entity.dart';
import 'package:order_manager/data/entities/orders/cliente_entity.dart';
import 'package:order_manager/data/entities/orders/item_entity.dart';
import 'package:order_manager/data/entities/orders/order_entity.dart';
import 'package:order_manager/data/entities/orders/payment_entity.dart';
import 'package:order_manager/data/models/components/chart_model.dart';
import 'package:order_manager/extentions/list_extentions.dart';
import 'package:order_manager/helpers/date_helper.dart';
import 'package:order_manager/helpers/format_helper.dart';
import 'package:order_manager/ui/components/app_chart.dart';
import '../../daos/orders/order_dao.dart';
import '../../data/models/reports/report_table_model.dart';
import '../../helpers/chart_helper.dart';

class ReportService {

  final OrderDao orderDao;

  ReportService({required this.orderDao});

  Future<List<ChartTypeModel>> getReportsCharts() async {
    final List<ChartTypeModel> charts = [];

    List<ItemEntity> items = await orderDao.findItems();
    List<Grouping<String, ItemEntity>> topItems = ChartHelper.getTopGrouped(items, (e) => e.name);

    // Gráfico de produtos
    charts.add(ChartTypeModel(
      title: "Top Produtos",
      type: ChartType.pie,
      showDataLabel: true,
      data: ChartHelper.mapToChartModel(topItems),
    ));

    List<OrderEntity> orders = await orderDao.findOrders();
    List<Grouping<String, OrderEntity>> topClients = ChartHelper.getTopGrouped(orders, (e) => e.clientId);

    List<ClientEntity> clients = await Future.wait(topClients.map((clientGroup) async {
      return (await orderDao.findClientForOrder(clientGroup.key))!;
    }));

    // Gráfico de vendas
    charts.add(ChartTypeModel(
      title: "Top Vendas",
      type: ChartType.bar,
      showDataLabel: false,
      data: ChartHelper.mapClientsToChartModel(topClients, clients),
    ));

    // Gráfico de pedidos
    charts.add(ChartTypeModel(
      title: "Pedidos",
      type: ChartType.bar,
      showDataLabel: false,
      data: ChartHelper.mapOrdersToChartModel(orders),
    ));

    return charts;
  }

  Future<List<ReportTableModel>> getReportTable(int index) async {
    if (index == 0) {
      // Relatório de itens
      List<ItemEntity> items = await orderDao.findItems();

      return items.groupBy((e) => e.name).map((e) {
        return ReportTableModel(
          name: e.key,
          quantity: e.values.length,
          total: e.values.first.unitPrice * e.values.length,
        );
      }).toList();
    } else {
      List<OrderEntity> orders = await orderDao.findOrders();

      if (index == 1) {
        // Relatório de pagamentos
        List<PaymentEntity> payments = await orderDao.findPayments();
        List<Grouping<String, OrderEntity>> groupByDate = orders.groupBy(
                (e) => FormatHelper.formatDate(DateTime.parse(e.createdAt))
        );

        final List<ReportTableModel> result = [];

        for (var dateGroup in groupByDate) {
          Map<String, double> paymentTotals = {};

          for (var order in dateGroup.values) {
            List<PaymentEntity> paymentsForOrder = payments.where((x) => x.orderId == order.id).toList();

            for (var payment in paymentsForOrder) {
              paymentTotals.update(payment.name, (existingValue) => existingValue + order.totalValue, ifAbsent: () => order.totalValue);
            }
          }

          bool isFirstEntry = true;

          paymentTotals.forEach((paymentName, totalValue) {
            result.add(ReportTableModel(
              name: isFirstEntry ? dateGroup.key : "",
              format: paymentName,
              total: totalValue,
              quantity: dateGroup.values.length,
            ));
            isFirstEntry = false;
          });
        }

        return result;
      } else if (index == 2) {
        // Relatório de endereços
        List<AddressEntity> addresses = await orderDao.findAddress();

        return addresses.groupBy((e) => e.city).map((e) {
          List<OrderEntity> addressOrders = orders.where((o) => e.values.any((v) => v.id == o.addressId)).toList();

          return ReportTableModel(
            name: e.key,
            quantity: addressOrders.length,
            total: addressOrders.fold(0.0, (sum, o) => sum + o.totalValue),
          );
        }).toList();
      } else {
        // Relatório de faixa etária
        List<ClientEntity> clients = await orderDao.findClients();

        return clients.groupBy((e) => DateHelper.getAgeGroup(e.birthDate)).map((e) {
          List<OrderEntity> clientsOrders = orders.where((o) => e.values.any((v) => v.id == o.clientId)).toList();

          return ReportTableModel(
            name: e.key,
            quantity: clientsOrders.length,
            total: clientsOrders.fold(0.0, (sum, o) => sum + o.totalValue),
          );
        }).toList();
      }
    }
  }
}