import 'package:flutter/material.dart';

class TableModel {

  final String text;
  final String value;
  final bool sortable;
  final bool editable;
  bool show;
  final TextAlign textAlign;
  final int flex;
  final Widget Function(dynamic value)? headerBuilder;
  final Widget Function(dynamic value, Map<String?, dynamic> row)? sourceBuilder;

  TableModel({
    required this.text,
    required this.value,
    this.textAlign = TextAlign.left,
    this.sortable = false,
    this.show = true,
    this.editable = false,
    this.flex = 1,
    this.headerBuilder,
    this.sourceBuilder,
  });

  factory TableModel.fromMap(Map<String, dynamic> map) => TableModel(
    text: map['text'],
    value: map['value'],
    sortable: map['sortable'],
    show: map['show'],
    textAlign: map['textAlign'],
    flex: map['flex'],
    headerBuilder: map['headerBuilder'],
    sourceBuilder: map['sourceBuilder'],
  );
  Map<String, dynamic> toMap() => {
    "text": this.text,
    "value": this.value,
    "sortable": this.sortable,
    "show": this.show,
    "textAlign": this.textAlign,
    "flex": this.flex,
    "headerBuilder": this.headerBuilder,
    "sourceBuilder": this.sourceBuilder,
  };
}
