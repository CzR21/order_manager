import 'package:floor/floor.dart';
import 'order_entity.dart';

@Entity(tableName: 'item',
  foreignKeys: [
    ForeignKey(
      childColumns: ['orderId'],
      parentColumns: ['id'],
      entity: OrderEntity,
      onDelete: ForeignKeyAction.cascade
    )
  ]
)
class ItemEntity {
  @PrimaryKey()
  final String id;

  final String productId;
  final String name;
  final int quantity;
  final double unitPrice;

  //FK
  final String orderId;

  ItemEntity({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.orderId,
  });
}
