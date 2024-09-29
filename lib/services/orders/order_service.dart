import 'package:order_manager/data/entities/orders/order_entity.dart';
import '../../daos/orders/order_dao.dart';
import '../../data/models/order/order_model.dart';
import '../../data/models/order/address_model.dart';
import '../../data/models/order/client_model.dart';
import '../../data/models/order/item_model.dart';
import '../../data/models/order/payment_model.dart';

class OrderService {

  final OrderDao orderDao;

  OrderService({required this.orderDao});


  Future<List<OrderModel>> getAllOrders() async {
    final List<OrderEntity> result = await orderDao.findOrders();

    return Future.wait(result.map((order) async {
      OrderModel newOrder = OrderModel.fromEntity(order);

      final addressFuture = orderDao.findAddressForOrder(order.addressId);
      final clientFuture = orderDao.findClientForOrder(order.clientId);
      final itemsFuture = orderDao.findItemsForOrder(order.id);
      final paymentsFuture = orderDao.findPaymentsForOrder(order.id);

      final address = await addressFuture;
      final client = await clientFuture;
      final items = await itemsFuture;
      final payments = await paymentsFuture;

      if (address != null) newOrder.address = AddressModel.fromEntity(address);
      if (client != null) newOrder.client = ClientModel.fromEntity(client);
      if (items.isNotEmpty) newOrder.items = items.map((e) => ItemModel.fromEntity(e)).toList();
      if (payments.isNotEmpty) newOrder.payments = payments.map((e) => PaymentModel.fromEntity(e)).toList();

      return newOrder;
    }).toList());
  }

  Future<void> saveOrders(List<OrderModel> orders) async {
    for (OrderModel order in orders) {
      await orderDao.insertClient(order.client!.toEntity());

      await orderDao.insertAddress(order.address!.toEntity());

      await orderDao.insertOrder(order.toEntity());

      if (order.items != null && order.items!.isNotEmpty) {
        await orderDao.insertItems(order.items!.map((e) => e.toEntity(order.id)).toList());
      }

      if (order.payments != null && order.payments!.isNotEmpty) {
        await orderDao.insertPayments(order.payments!.map((e) => e.toEntity(order.id)).toList());
      }
    }
  }
}