import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/models/table_column_model/table_column_change_buttton_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';

class TableColumnChangeButton extends TableColumn {
  TableColumnChangeButton(
      {super.filter, required super.title, required super.type, super.colspan});

  @override
  Widget render({required TableColumnModel? data}) {
    if (data is TableColumnChangeButtonModel) {
      return SizedBox(
        width: 32,
        height: 32,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
        ),
      );
    } else {
      return Text(
        "error ${data.runtimeType}  not TableColumnChangeButtonModel",
        style: const TextStyle(color: Colors.red, fontSize: 12),
      );
    }
  }
}
