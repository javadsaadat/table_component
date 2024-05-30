import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';

class TableController extends ChangeNotifier {
  List<Map<String, TableColumnModel>> rows;
  TableController({
    required this.rows,
  });
  changeRow({required List<Map<String, TableColumnModel>> rows}) {
    rows = rows;
    notifyListeners();
  }
}
