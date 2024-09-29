import 'package:floor/floor.dart';
import 'order_entity.dart';

@Entity(tableName: 'payment',
  foreignKeys: [
    ForeignKey(
      childColumns: ['orderId'],
      parentColumns: ['id'],
      entity: OrderEntity,
      onDelete: ForeignKeyAction.cascade
    )
  ]
)
class PaymentEntity {
  @PrimaryKey()
  final String id;

  final int installment;
  final double value;
  final String code;
  final String name;

  //FK
  final String orderId;

  PaymentEntity({
    required this.id,
    required this.installment,
    required this.value,
    required this.code,
    required this.name,
    required this.orderId,
  });
}
