import 'package:flutter/material.dart';
import 'package:order_manager/data/entities/orders/order_entity.dart';
import 'package:order_manager/helpers/format_helper.dart';
import '../../../settings/app_colors.dart';
import '../../../settings/app_fonts.dart';
import 'client_model.dart';
import 'address_model.dart';
import 'item_model.dart';
import 'payment_model.dart';

class OrderModel{

  final String id;
  final int number;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final double discount;
  final double shippingCost;
  final double subTotal;
  final double totalValue;

  ClientModel? client;
  AddressModel? address;
  List<ItemModel>? items;
  List<PaymentModel>? payments;

  OrderModel({
    required this.id,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.discount,
    required this.shippingCost,
    required this.subTotal,
    required this.totalValue,
    this.client,
    this.address,
    this.items,
    this.payments,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      number: json['numero'],
      createdAt: DateTime.parse(json['dataCriacao']),
      updatedAt: DateTime.parse(json['dataAlteracao']),
      status: json['status'],
      discount: json['desconto'].toDouble(),
      shippingCost: json['frete'].toDouble(),
      subTotal: json['subTotal'].toDouble(),
      totalValue: json['valorTotal'].toDouble(),
      client: ClientModel.fromJson(json['cliente']),
      address: AddressModel.fromJson(json['enderecoEntrega']),
      items: (json['itens'] as List).map((item) => ItemModel.fromJson(item)).toList(),
      payments: (json['pagamento'] as List).map((payment) => PaymentModel.fromJson(payment)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'createdAt': FormatHelper.formatFullDate(createdAt),
      'status': status,
      'subTotal': FormatHelper.formatCurrency(subTotal),
      'totalAmount': FormatHelper.formatCurrency(totalValue),
      'client': client?.name ?? "",
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      number: entity.number,
      createdAt: DateTime.parse(entity.createdAt),
      updatedAt: DateTime.parse(entity.updatedAt),
      status: entity.status,
      discount: entity.discount,
      shippingCost: entity.shippingCost,
      subTotal: entity.subTotal,
      totalValue: entity.totalValue,
    );
  }

  OrderEntity toEntity() => OrderEntity(
    id: id,
    number: number,
    createdAt: createdAt.toString(),
    updatedAt: updatedAt.toString(),
    status: status,
    discount: discount,
    shippingCost: shippingCost,
    subTotal: subTotal,
    totalValue: totalValue,
    clientId: client?.id ?? "",
    addressId: address?.id ?? "",
  );

  Widget get converterModelToWidget => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Informações do Pedido", style: AppFonts.bodyBoldLarge.copyWith(color: AppColors.blueDefaultColor),),
        const SizedBox(height: 5,),
        Text("Número: $number", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Data Criação: ${FormatHelper.formatDate(createdAt)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Data Alteração: ${FormatHelper.formatDate(updatedAt)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Status: $status", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Desconto: ${FormatHelper.formatCurrency(discount)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Frete: ${FormatHelper.formatCurrency(shippingCost)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("SubTotal: ${FormatHelper.formatCurrency(subTotal)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Total: ${FormatHelper.formatCurrency(totalValue)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
      ],
    ),
  );
}