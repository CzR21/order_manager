import 'package:floor/floor.dart';

@Entity(tableName: 'address')
class AddressEntity {
  @PrimaryKey()
  final String id;

  final String address;
  final String number;
  final String zipCode;
  final String neighborhood;
  final String city;
  final String state;
  final String complement;
  final String reference;

  AddressEntity({
    required this.id,
    required this.address,
    required this.number,
    required this.zipCode,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.complement,
    required this.reference,
  });
}
