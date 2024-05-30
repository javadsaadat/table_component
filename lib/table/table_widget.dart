import 'package:flutter/material.dart';
import 'package:table_component/table/controller/table_controller.dart';
import 'package:table_component/table/models/table_column_model.dart';
import 'package:table_component/table/table_columns/table_columns.dart';
import 'package:table_component/table/widgets/table_header_widget.dart';
import 'package:table_component/table/widgets/table_row_widget.dart';

class TableWidget extends StatefulWidget {
  const TableWidget(
      {super.key,
      required this.columns,
      required this.rows,
      this.dividerCell,
      this.dividerRow});
  final List<TableColumn> columns;
  final List<Map<String, TableColumnModel>> rows;
  final bool? dividerCell;
  final bool? dividerRow;
  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  late TableController tableController;
  late List<TableColumn> columns;
  GlobalKey sizedBoxKey = GlobalKey();
  RenderBox? box;
  int sumColSpan = 0;
  double sizeOFOneColSpan = 0;
  double widthTable = 0;
  double widthBorderMainContainer = 1;
  double ratioOfContainerWidthToTotalWindows = 0;

  @override
  void initState() {
    tableController = TableController(rows: widget.rows);
    tableController.addListener(() {
      setState(() {});
    });
    columns = widget.columns;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      box = (sizedBoxKey.currentContext!.findRenderObject() as RenderBox);
      widthTable = box!.size.width;
      for (var column in columns) {
        sumColSpan += column.colspan <= 0 ? 1 : column.colspan;
      }

      ratioOfContainerWidthToTotalWindows =
          (widthTable) / MediaQuery.of(context).size.width; /* between 0 or 1 */
      setState(() {});
    });
    super.initState();
  }

  /*  @override
  void dispose() {
    tableController.removeListener(rebuild());
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    if (box == null) {
      return Container(
        key: sizedBoxKey,
        color: Colors.transparent,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      widthTable = constraints.maxWidth * ratioOfContainerWidthToTotalWindows;
      sizeOFOneColSpan =
          (widthTable - (widthBorderMainContainer * 2 /* left and right  */)) /
              sumColSpan;
      return SingleChildScrollView(
        /* For when the AnimatedContainers is running*/
        scrollDirection: Axis.horizontal,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border.all(
              width: widthBorderMainContainer,
              color: Colors.black.withOpacity(0.05999999865889549),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  return const Row(
                    children: [] /* columnsFilterd
                        .map((col) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 50,
                                height: 30,
                                child: Text(col.filter.value),
                              ),
                            ))
                        .toList() */
                    ,
                  );
                }),
                TableHeaderWidget(
                  sizeOFOneColSpan: sizeOFOneColSpan,
                  columns: columns,
/*                   onChangeSortColumnAndFiltered: (columns, rows) {},
 */
                  rows: tableController.rows,
                ),
                for (Map<String, TableColumnModel> row in tableController.rows)
                  TableRowWidget(
                    columns: columns,
                    row: row,
                    dividerRow: widget.dividerRow ?? true,
                    sizeOFOneColSpan: sizeOFOneColSpan,
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
