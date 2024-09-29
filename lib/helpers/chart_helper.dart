import '../data/entities/orders/cliente_entity.dart';
import '../data/entities/orders/order_entity.dart';
import '../data/models/components/chart_model.dart';
import '../extentions/list_extentions.dart';

class ChartHelper{

  static List<Grouping<K, T>> getTopGrouped<T, K>(List<T> items, K Function(T) keySelector) {
    List<Grouping<K, T>> grouped = items.groupBy(keySelector);
    grouped.sort((a, b) => b.values.length.compareTo(a.values.length));
    return grouped.take(5).toList();
  }

  static List<ChartModel> mapToChartModel<K, T>(List<Grouping<K, T>> groupedItems) => groupedItems.map((e) => ChartModel(
    name: e.key.toString(),
    value: e.values.length,
  )).toList();

  static List<ChartModel> mapClientsToChartModel(List<Grouping<String, OrderEntity>> topClients, List<ClientEntity> clients) => clients.map((client) {
    Grouping<String, OrderEntity> clientGroup = topClients.firstWhere((c) => c.key == client.id);

    return ChartModel(
      name: client.name,
      value: clientGroup.values.length ?? 0,
    );
  }).toList();

  static List<ChartModel> mapOrdersToChartModel(List<OrderEntity> orders) => orders.groupBy((e) => e.status)
    .map((e) => ChartModel(
      name: e.key,
      value: e.values.length,
    )
  ).toList();

}