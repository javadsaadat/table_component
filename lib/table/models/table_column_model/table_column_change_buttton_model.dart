import 'package:table_component/table/models/table_column_model.dart';

class TableColumnChangeButtonModel extends TableColumnModel {
  final void Function() ontTab;
  TableColumnChangeButtonModel({
    required this.ontTab,
  });
}
