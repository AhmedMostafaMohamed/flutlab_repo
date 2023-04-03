import 'package:flutter/material.dart';

import '../../data/models/child.dart';

class ChildDataTable extends DataTableSource {
  final List<Child> data;

  ChildDataTable({required this.data});
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index].name!)),
      DataCell(Text(data[index].gender!)),
      DataCell(Text(data[index].dob.toString())),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
