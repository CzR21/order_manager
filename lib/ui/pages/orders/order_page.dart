import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_manager/helpers/dialog_helper.dart';
import 'package:order_manager/settings/app_assets.dart';
import 'package:order_manager/settings/app_colors.dart';
import 'package:order_manager/ui/components/app_buttom.dart';
import 'package:order_manager/ui/components/app_table.dart';
import 'package:order_manager/ui/components/app_textfield.dart';
import 'package:order_manager/ui/pages/orders/order_controller.dart';
import 'package:order_manager/ui/pages/orders/widgets/order_items_popup.dart';
import '../../../utils/table_utils.dart';
import '../../components/app_scaffold.dart';
import 'order_binding.dart';
import 'widgets/order_details_widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  final AppTextFieldController _searchController = AppTextFieldController();

  late OrderController _controller;
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
    await setUpOrder();
    _controller = Get.find<OrderController>();
    _controller.getOrders();
  }

  //Padding + buttonSize
  double get calculateSizePage => 30 + 112;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Pedidos",
      body: Container(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (_, constrains){
            return FutureBuilder(
              future: _setupController,
              builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done
                ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: constrains.maxWidth*5/7,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller: _searchController,
                                hint: "Pesquisar",
                                prefixIcon: SvgPicture.asset(
                                  AppAssets.searchIcon,
                                  color: AppColors.greyColor,
                                ),
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Obx(() => AppButton(
                              onPressed: () => _controller.syncOrders(),
                              label: "Sincronizar",
                              isLoading: _controller.isLoading.value,
                            ))
                          ],
                        ),

                        const SizedBox(height: 10,),

                        Obx(() => AppTable(
                          maxHeight: (constrains.maxHeight - 54),
                          headers: TableUtils.orderTableColumns(),
                          selected: _controller.orderSelected?.toMap(),
                          source: _controller.orders
                            .map((e) => e.toMap())
                            .where((e) => e.values.any((v) => v.toString().toLowerCase().startsWith(_searchController.textEditingController.text.toLowerCase())))
                            .toList(),
                          onTabRow: (value) => _controller.orderSelected = _controller.orders.firstWhere((x) => x.number == value['number']),
                          onDoubleTabRow: (value) {
                            _controller.orderSelected = _controller.orders.firstWhere((x) => x.number == value['number']);
                            DialogHelper.show(
                              context: context,
                              title: "Detalhes do pedido",
                              body: OrderItemsPopup(orderModel: _controller.orderSelected!,),
                            );
                          },
                        ))
                      ],
                    ),
                  ),

                  Obx(() => SizedBox(
                      width: (constrains.maxWidth - calculateSizePage) * 2/7,
                      child: OrderDetailsWidget(
                        orderModel: _controller.orderSelected,
                      )
                    )
                  ),
                ],
              ) : const Center(child: CircularProgressIndicator(color: AppColors.blueDarkColor,),)
            );
          }
        ),
      ),
    );
  }
}