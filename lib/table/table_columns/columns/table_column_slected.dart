import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/models/table_column_model/table_column_slected_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';

class TableColumnSelected extends TableColumn {
  TableColumnSelected(
      {required super.filter,
      required super.title,
      required super.type,
      super.colspan});

  @override
  Widget render({required TableColumnModel? data}) {
    if (data is TableColumnSelectedModel) {
      return GestureDetector(
        onTap: () {
          data.onTab(data.isSelected);
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Center(
            child: Icon(data.isSelected ? Icons.check : Icons.close),
          ),
        ),
      );
    } else {
      return Text(
        "error ${data.runtimeType}  not  TableColumnSelectedModel",
        style: const TextStyle(color: Colors.red, fontSize: 12),
      );
    }
  }
}
