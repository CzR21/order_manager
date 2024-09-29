import 'package:order_manager/data/entities/orders/item_entity.dart';
import '../../../helpers/format_helper.dart';

class ItemModel {

  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double unitPrice;

  ItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      productId: json['idProduto'],
      name: json['nome'],
      quantity: json['quantidade'],
      unitPrice: json['valorUnitario'].toDouble(),
    );
  }

  factory ItemModel.fromEntity(ItemEntity entity) {
    return ItemModel(
      id: entity.id,
      productId: entity.productId,
      name: entity.name,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unitPrice': FormatHelper.formatCurrency(unitPrice),
    };
  }

  ItemEntity toEntity(String orderId) => ItemEntity(
    id: id,
    orderId: orderId,
    productId: productId,
    name: name,
    quantity: quantity,
    unitPrice: unitPrice,
  );
}