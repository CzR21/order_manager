import 'package:floor/floor.dart';

@Entity(tableName: 'client')
class ClientEntity {
  @PrimaryKey()
  final String id;

  final String cnpj;
  final String cpf;
  final String name;
  final String corporateName;
  final String email;
  final String birthDate;

  ClientEntity({
    required this.id,
    required this.cnpj,
    required this.cpf,
    required this.name,
    required this.corporateName,
    required this.email,
    required this.birthDate,
  });
}
