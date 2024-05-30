import 'package:flutter/material.dart';
import 'package:table_component/table/table_filter_model/table_filter.dart';
import 'package:table_component/toltip_widget/toltip_widget.dart';

class TableFilterText extends TableFilter<String> {
  final Function({required String value}) onSubmit;
  TableFilterText(this.onSubmit);
  @override
  Widget render() {
    print("________________________________");
    return ToltipWidget(
        content: Container(
          color: Colors.white,
          width: 300,
          child: TextField(
            onChanged: (value) {
              onSubmit(value: value);
            },
          ),
        ),
        child: const Icon(Icons.filter_alt_outlined));
  }
}
