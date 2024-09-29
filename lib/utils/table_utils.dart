import 'package:flutter/material.dart';
import 'package:order_manager/data/models/components/table_model.dart';

class TableUtils{

  static List<TableModel> orderTableColumns() => [
    TableModel(
      text: "Número",
      value: "number",
    ),
    TableModel(
      text: "Data",
      value: "createdAt",
      flex: 3,
    ),
    TableModel(
      text: "Cliente",
      value: "client",
      flex: 4,
    ),
    TableModel(
      text: "Valor",
      value: "subTotal",
    ),
    TableModel(
      text: "Status",
      value: "status",
    ),
    TableModel(
      text: "Valor total",
      value: "totalAmount",
    ),
  ];

  static List<TableModel> itemsTableColumns() => [
    TableModel(
        text: "Produto",
        value: "name",
        flex: 2,
    ),
    TableModel(
        text: "Qtde",
        value: "quantity",
    ),
    TableModel(
        text: "Valor Unit.",
        value: "unitPrice",
    ),
  ];

  static List<TableModel> paymentsTableColumns() => [
    TableModel(
        text: "Pagamento",
        value: "name",
        flex: 2,
    ),
    TableModel(
        text: "Parcela",
        value: "installment",
    ),
    TableModel(
        text: "Valor",
        value: "amount",
    ),
  ];

  static List<TableModel> reportTableColumns(int index) => [
    TableModel(
      text: index == 0 ? "Produto" : index == 1 ? "Data" : index == 2 ? "Cidade" : "Faixa Etária",
      value: "name",
      flex: index == 1 ? 1 : 4,
    ),
    TableModel(
      text: index == 1 ? "Forma" : "Quantidade",
      value: index == 1 ? "format" : "quantity",
    ),
    TableModel(
      text: index == 0 ? "Valor médio" : "Valor",
      value: "total",
    ),
  ];
}

