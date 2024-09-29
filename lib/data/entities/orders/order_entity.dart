import 'package:floor/floor.dart';

@Entity(tableName: 'order')
class OrderEntity {
  @PrimaryKey()
  final String id;

  final int number;
  final String createdAt;
  final String updatedAt;
  final String status;
  final double discount;
  final double shippingCost;
  final double subTotal;
  final double totalValue;

  //FK
  final String clientId;
  final String addressId;

  OrderEntity({
    required this.id,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.discount,
    required this.shippingCost,
    required this.subTotal,
    required this.totalValue,
    required this.clientId,
    required this.addressId,
  });
}
