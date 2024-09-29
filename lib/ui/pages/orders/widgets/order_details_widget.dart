import 'package:flutter/material.dart';
import 'package:order_manager/data/models/order/order_model.dart';
import 'package:order_manager/settings/app_colors.dart';
import 'package:order_manager/settings/app_fonts.dart';

class OrderDetailsWidget extends StatelessWidget {

  final OrderModel? orderModel;

  const OrderDetailsWidget({super.key, this.orderModel});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return SizedBox(
          height: constrains.maxHeight,
          child: Card(
            elevation: 1,
            shadowColor: Colors.black,
            clipBehavior: Clip.none,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.blueDefaultColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      alignment: Alignment.center,
                      child: Text("Detalhes do Pedido", style: AppFonts.bodyBoldDefault.copyWith(
                        color: AppColors.whiteColor
                      ),),
                    ),
                    orderModel == null
                    ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Nenhum pedido selecionado", style: AppFonts.bodyRegularDefault.copyWith(color: AppColors.blackColor),),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderModel?.converterModelToWidget ?? Container(),
                        orderModel?.client?.converterModelToWidget ?? Container(),
                        orderModel?.address?.converterModelToWidget ?? Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
