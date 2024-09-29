import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:order_manager/repositories/orders/order_repository.dart';
import 'package:order_manager/ui/pages/orders/order_controller.dart';
import '../../../services/orders/order_service.dart';
import '../../../settings/app_database.dart';

Future setUpOrder() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  Get.put<OrderController>(
    OrderController(
      orderRepository: OrderRepository(
        dio: Dio()
      ),
      orderService: OrderService(
        orderDao: database.orderDao
      ),
    )
  );
}