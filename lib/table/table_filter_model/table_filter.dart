// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

abstract class TableFilter<T> {
  /* set value(T? newValue);
  T? get value;
  List<Map<String, TableColumnModel>> filter(
      {required List<Map<String, TableColumnModel>> rows,
      required String type});

 */

  Widget render();
}
