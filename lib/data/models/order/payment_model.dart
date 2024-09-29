import 'package:order_manager/data/entities/orders/payment_entity.dart';
import 'package:order_manager/helpers/format_helper.dart';

class PaymentModel {
  final String id;
  final int installment;
  final double value;
  final String code;
  final String name;

  PaymentModel({
    required this.id,
    required this.installment,
    required this.value,
    required this.code,
    required this.name,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      installment: json['parcela'],
      value: json['valor'].toDouble(),
      code: json['codigo'],
      name: json['nome'],
    );
  }

  factory PaymentModel.fromEntity(PaymentEntity entity) {
    return PaymentModel(
      id: entity.id,
      installment: entity.installment,
      value: entity.value,
      code: entity.code,
      name: entity.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'installment': installment,
      'amount': FormatHelper.formatCurrency(value),
    };
  }

  PaymentEntity toEntity(String orderId) => PaymentEntity(
    id: id,
    orderId: orderId,
    installment: installment,
    value: value,
    code: code,
    name: name,
  );
}