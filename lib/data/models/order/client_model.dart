import 'package:flutter/material.dart';
import 'package:order_manager/helpers/format_helper.dart';
import '../../../settings/app_colors.dart';
import '../../../settings/app_fonts.dart';
import '../../entities/orders/cliente_entity.dart';

class ClientModel {
  final String id;
  final String cnpj;
  final String cpf;
  final String name;
  final String corporateName;
  final String email;
  final DateTime birthDate;

  ClientModel({
    required this.id,
    required this.cnpj,
    required this.cpf,
    required this.name,
    required this.corporateName,
    required this.email,
    required this.birthDate,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      cnpj: json['cnpj'],
      cpf: json['cpf'],
      name: json['nome'],
      corporateName: json['razaoSocial'],
      email: json['email'],
      birthDate: DateTime.parse(json['dataNascimento']),
    );
  }

  factory ClientModel.fromEntity(ClientEntity entity) {
    return ClientModel(
      id: entity.id,
      cnpj: entity.cnpj,
      cpf: entity.cpf,
      name: entity.name,
      corporateName: entity.corporateName,
      email: entity.email,
      birthDate: DateTime.parse(entity.birthDate),
    );
  }

  ClientEntity toEntity() => ClientEntity(
    id: id,
    cnpj: cnpj,
    cpf: cpf,
    name: name,
    corporateName: corporateName,
    email: email,
    birthDate: birthDate.toString(),
  );

  Widget get converterModelToWidget => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Dados do Cliente", style: AppFonts.bodyBoldLarge.copyWith(color: AppColors.blueDefaultColor), ),
        const SizedBox(height: 5,),
        Text("Cliente: $name", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor), ),
        Text("Documento: ${cpf.isNotEmpty ? FormatHelper.formatCPF(cpf) : FormatHelper.formatCNPJ(cnpj)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor), ),
        Text("Data Nascimento: ${FormatHelper.formatDate(birthDate)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor), ),
        Text("E-mail: $email", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor), ),
      ],
    ),
  );
}