import 'package:table_component/table/models/table_column_model.dart';

class TableColumnSelectedModel extends TableColumnModel {
  final bool isSelected;
  final Function(bool) onTab;
  TableColumnSelectedModel({
    required this.isSelected,
    required this.onTab,
  });
}
