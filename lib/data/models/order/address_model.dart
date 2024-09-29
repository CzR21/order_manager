import 'package:flutter/material.dart';
import 'package:order_manager/data/entities/orders/address_entity.dart';
import '../../../helpers/format_helper.dart';
import '../../../settings/app_colors.dart';
import '../../../settings/app_fonts.dart';

class AddressModel {

  final String id;
  final String address;
  final String number;
  final String zipCode;
  final String neighborhood;
  final String city;
  final String state;
  final String complement;
  final String reference;

  AddressModel({
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

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      address: json['endereco'],
      number: json['numero'],
      zipCode: json['cep'],
      neighborhood: json['bairro'],
      city: json['cidade'],
      state: json['estado'],
      complement: json['complemento'],
      reference: json['referencia'],
    );
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      address: entity.address,
      number: entity.number,
      zipCode: entity.zipCode,
      neighborhood: entity.neighborhood,
      city: entity.city,
      state: entity.state,
      complement: entity.complement,
      reference: entity.reference,
    );
  }

  AddressEntity toEntity() => AddressEntity(
    id: id,
    address: address,
    number: number,
    zipCode: zipCode,
    neighborhood: neighborhood,
    city: city,
    state: state,
    complement: complement,
    reference: reference,
  );

  Widget get converterModelToWidget => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Local de Entrega", style: AppFonts.bodyBoldLarge.copyWith(color: AppColors.blueDefaultColor),),
        const SizedBox(height: 5,),
        Text("Endereço: $address", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Número: $number", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("CEP: ${FormatHelper.formatZipCode(zipCode)}", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Bairro: $neighborhood", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Cidade: $city", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Estado: $state", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Complemento: $complement", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
        Text("Referência: $reference", style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
      ],
    ),
  );
}