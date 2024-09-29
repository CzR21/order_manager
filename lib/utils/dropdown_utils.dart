import '../data/models/components/dropdown_model.dart';

class DropdownUtils{

  static List<DropdownModel> getReportsValues() => [
    DropdownModel(key: "Listagem de produtos mais vendidos", value: 0),
    DropdownModel(key: "Totalização de Formas de Pagamentos por Dia", value: 1),
    DropdownModel(key: "Totalização de Vendas por Cidade", value: 2),
    DropdownModel(key: "Totalização de Vnedas por Faixa Etária", value: 3),
  ];

}