import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_manager/data/models/order/order_model.dart';
import 'package:order_manager/helpers/snackbar_helper.dart';
import 'package:order_manager/repositories/orders/order_repository.dart';
import '../../../data/models/components/snackbar_model.dart';
import '../../../services/orders/order_service.dart';
import '../../../settings/app_routes.dart';

class OrderController extends GetxController{

  final OrderRepository orderRepository;
  final OrderService orderService;

  final RxList<OrderModel> _orders = <OrderModel>[].obs;
  List<OrderModel> get orders => _orders;

  final Rx<OrderModel?> _orderSelected = Rx<OrderModel?>(null);
  OrderModel? get orderSelected => _orderSelected.value;
  set orderSelected(OrderModel? value) => _orderSelected.value = value;

  final Rx<SnackBarModel?> _snackBarModel = Rx<SnackBarModel?>(null);
  SnackBarModel? get snackBarModel => _snackBarModel.value;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  OrderController({
    required this.orderRepository,
    required this.orderService
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

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  Future syncOrders() async {
    try{
      _isLoading.value = true;

      _orders.value = await orderRepository.getOrders();
      await orderService.saveOrders(_orders);

      _snackBarModel.value = SnackBarModel(
        message: "Pedidos sincronizados com sucesso",
        snackBarType: SnackBarType.success,
      );
    }
    catch (ex){
      _snackBarModel.value = SnackBarModel(
        message: "Erro ao sincronizar pedidos",
        snackBarType: SnackBarType.error,
      );
    }
    finally{
      _isLoading.value = false;
    }
  }

  Future getOrders() async {
    try{
      _orders.value = await orderService.getAllOrders();
    }
    catch (ex){
      _snackBarModel.value = SnackBarModel(
        message: "Erro ao buscar pedidos",
        snackBarType: SnackBarType.error,
      );
    }
  }
}