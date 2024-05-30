import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/table_filter_model/table_filter.dart';

abstract class TableColumn {
  final String title;
  final String type;
  final int colspan;
  final TableFilter? filter;

  TableColumn({
    this.filter,
    this.colspan = 1,
    required this.title,
    required this.type,
  });
  Widget render({required TableColumnModel? data});
}
