import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/models/table_column_model/table_column_text_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';

class TableColumnChoiceChip extends TableColumn {
  TableColumnChoiceChip(
      {required super.filter,
      required super.title,
      required super.type,
      super.colspan});

  @override
  Widget render({required TableColumnModel? data}) {
    if (data is TableColumnTextModel) {
      return Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
        child: Text(
          data.text,
          style: const TextStyle(fontSize: 20),
        ),
      );
    } else {
      return Text(
        "error ${data.runtimeType}  not  TableColumnTextModel",
        style: const TextStyle(color: Colors.red, fontSize: 12),
      );
    }
  }
}
