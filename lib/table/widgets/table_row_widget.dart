import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';

class TableRowWidget extends StatefulWidget {
  const TableRowWidget({
    super.key,
    required this.columns,
    required this.row,
    required this.dividerRow,
    required this.sizeOFOneColSpan,
  });

  final List<TableColumn> columns;
  final Map<String, TableColumnModel> row;
  final bool dividerRow;
  final double sizeOFOneColSpan;

  @override
  State<TableRowWidget> createState() => _TableRowWidgetState();
}

class _TableRowWidgetState extends State<TableRowWidget> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          hover = value;
        });
      },
      child: IntrinsicHeight(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          decoration: BoxDecoration(
            color: hover ? const Color(0xFFFAFAFA) : Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.05999999865889549),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (TableColumn column in widget.columns)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: (column.colspan <= 0 ? 1 : column.colspan) *
                      widget.sizeOFOneColSpan,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      right: Directionality.of(context) == TextDirection.ltr
                          ? BorderSide(
                              width: 1,
                              color:
                                  Colors.black.withOpacity(0.05999999865889549),
                            )
                          : BorderSide.none,
                      left: Directionality.of(context) == TextDirection.rtl
                          ? BorderSide(
                              width: 1,
                              color:
                                  Colors.black.withOpacity(0.05999999865889549),
                            )
                          : BorderSide.none,
                    ),
                  ),
                  child: column.render(
                    data: widget.row[column.type],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
