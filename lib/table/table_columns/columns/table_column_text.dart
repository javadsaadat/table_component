import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/models/table_column_model/table_column_text_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';

class TableColumnText extends TableColumn {
  TableColumnText(
      {super.filter, required super.title, required super.type, super.colspan});

  @override
  Widget render({required TableColumnModel? data}) {
    if (data is TableColumnTextModel) {
      return Text(
        data.text,
        style: TextStyle(
          color: Colors.black.withOpacity(0.8799999952316284),
          fontSize: 12,
          fontFamily: 'Peyda',
          fontWeight: FontWeight.w400,
        ),
      );
    } else {
      return Text(
        "error ${data.runtimeType}  not TableColumnTextModel",
        style: const TextStyle(color: Colors.red, fontSize: 12),
      );
    }
  }
}
