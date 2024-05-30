import 'package:flutter/material.dart';
import 'package:table_component/table/models/table_column_model/table_column_change_buttton_model.dart';
import 'package:table_component/table/models/table_column_model/table_column_text_model.dart';
import 'package:table_component/table/models/table_column_model/table_column_user_model.dart';
import 'package:table_component/table/table_columns/columns/table_column_change_buttton.dart';
import 'package:table_component/table/table_columns/columns/table_column_choice_chip.dart';
import 'package:table_component/table/table_columns/columns/table_column_text.dart';
import 'package:table_component/table/table_columns/columns/table_column_user.dart';
import 'package:table_component/table/table_filter_model/table_filters/table_filter_text.dart';
import 'package:table_component/table/table_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 81, 183)),
        useMaterial3: true,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.tealAccent,
              title: Text(
                " Table Component",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Text("Tabel Widget"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableWidget(
                      columns: [
                        TableColumnChoiceChip(
                          title: "وضعیت",
                          type: "status",
                          colspan: 2,
                          filter: TableFilterText(({required value}) {
                            print("status $value");
                          }),
                        ),
                        TableColumnText(
                          title: "رشته تحصیلی",
                          type: "reshte",
                          filter: TableFilterText(({required value}) {
                            print("reshte $value");
                          }),
                        ),
                        TableColumnUser(
                          title: "نام و نام خانوادگی",
                          type: "user",
                          colspan: 3,
                          filter: TableFilterText(({required value}) {
                            print("user $value");
                          }),
                        ),
                        TableColumnText(
                          title: "شماره تماس",
                          type: "phN",
                        ),
                        TableColumnText(
                          title: "شهر",
                          type: "city",
                        ),
                        TableColumnText(
                          title: "ورودی",
                          type: "entry",
                        ),
                        TableColumnChangeButton(
                          title: "fgghf",
                          type: "edit",
                        )
                      ],
                      rows: [
                        for (int i = 0; i < 10; i++)
                          {
                            "status": TableColumnTextModel(text: "status$i"),
                            "user": TableColumnUserModel(
                                avatar: "avatar$i",
                                name: "name$i",
                                userCode: "userCode$i"),
                            "reshte": TableColumnTextModel(text: "reshte$i"),
                            "phN": TableColumnTextModel(text: "phN$i"),
                            "city": TableColumnTextModel(text: "city$i"),
                            "entry": TableColumnTextModel(text: "entry$i"),
                            "edit": TableColumnChangeButtonModel(
                              ontTab: () {},
                            ),
                          }
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
