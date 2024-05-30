import 'package:table_component/table/models/table_column_model.dart';

class TableColumnTextButtonModel extends TableColumnModel {
  final String lable;
  final void Function() onTab;
  TableColumnTextButtonModel({
    required this.lable,
    required this.onTab,
  });
}
