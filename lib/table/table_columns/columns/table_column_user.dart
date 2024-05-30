import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/models/table_column_model/table_column_user_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';

class TableColumnUser extends TableColumn {
  TableColumnUser(
      {required super.filter,
      required super.title,
      required super.type,
      super.colspan});

  @override
  Widget render({required TableColumnModel? data}) {
    if (data is TableColumnUserModel) {
      return Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 15,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Peyda',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                data.userCode,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black.withOpacity(0.6499999761581421),
                  fontSize: 12,
                  fontFamily: 'Peyda',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Text(
        "error ${data.runtimeType} not TableColumnUserModel",
        style: const TextStyle(color: Colors.red, fontSize: 12),
      );
    }
  }
}
