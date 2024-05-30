import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/models/table_column_model/table_column_text_button_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';

class TableColumnTextButton extends TableColumn {
  TableColumnTextButton(
      {required super.filter,
      required super.title,
      required super.type,
      super.colspan});

  @override
  Widget render({required TableColumnModel? data}) {
    if (data is TableColumnTextButtonModel) {
      return TextButton(
        onPressed: () {
          data.onTab();
        },
        child: Text(
          data.lable,
          style: const TextStyle(fontSize: 20),
        ),
      );
    } else {
      return Text(
        "error ${data.runtimeType}  not  TableColumnTextButtonModel",
        style: const TextStyle(color: Colors.red, fontSize: 12),
      );
    }
  }
}
