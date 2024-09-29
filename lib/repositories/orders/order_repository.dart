import 'package:dio/dio.dart';
import 'package:order_manager/data/models/order/order_model.dart';
import 'package:order_manager/settings/app_api.dart';

class OrderRepository{

  final Dio dio;

  OrderRepository({required this.dio});

  Future<List<OrderModel>> getOrders() async {
    final response = await dio.get(AppApi.orders);

    return response.data is List
      ? (response.data as List).map((e) => OrderModel.fromJson(e)).toList()
      : List.empty();
  }
}