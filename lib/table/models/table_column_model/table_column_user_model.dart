import 'package:table_component/table/models/table_column_model.dart';

class TableColumnUserModel extends TableColumnModel {
  final String avatar;
  final String name;
  final String userCode;
  TableColumnUserModel({
    required this.avatar,
    required this.name,
    required this.userCode,
  });
}
