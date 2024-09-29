import 'package:flutter/material.dart';
import 'package:order_manager/data/models/order/order_model.dart';
import 'package:order_manager/settings/app_media_query.dart';
import '../../../../utils/table_utils.dart';
import '../../../components/app_table.dart';

class OrderItemsPopup extends StatefulWidget {

  final OrderModel orderModel;

  const OrderItemsPopup({super.key, required this.orderModel});

  @override
  State<OrderItemsPopup> createState() => _OrderItemsPopupState();
}

class _OrderItemsPopupState extends State<OrderItemsPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: constrains.maxWidth / 2 - 25,
                child: AppTable(
                  selected: null,
                  maxHeight: deviceHeight(context) - 200,
                  headers: TableUtils.itemsTableColumns(),
                  source: widget.orderModel.items!.map((e) => e.toMap()).toList(),
                ),
              ),

              SizedBox(
                width: constrains.maxWidth / 2 - 25,
                child: AppTable(
                  selected: null,
                  maxHeight: deviceHeight(context) - 200,
                  headers: TableUtils.paymentsTableColumns(),
                  source: widget.orderModel.payments!.map((e) => e.toMap()).toList(),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
