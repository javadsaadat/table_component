import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';

class TableHeaderWidget extends StatelessWidget {
  const TableHeaderWidget({
    super.key,
    required this.columns,
    required this.sizeOFOneColSpan,
    required this.rows,
  });
  final List<TableColumn> columns;
  final List<Map<String, TableColumnModel>> rows;

  final double sizeOFOneColSpan;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(columns.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            width: (columns[index].colspan * sizeOFOneColSpan),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.019999999552965164),
              border: Border.symmetric(
                vertical: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.05999999865889549),
                ),
              ),
            ),
            child: Builder(builder: (context) {
              return Wrap(
                spacing: 8.0,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    columns[index].title,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8799999952316284),
                      fontSize: 14,
                      fontFamily: 'Peyda',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (columns[index].filter != null)
                    columns[index].filter!.render(),
                ],
              );
            }),
          );
        }),
      ),
    );
  }
}
